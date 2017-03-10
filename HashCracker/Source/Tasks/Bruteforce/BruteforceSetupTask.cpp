#include "Config.hpp"

#include "Tasks/Bruteforce/BruteforceSetupTask.hpp"

#include "ProgramEntry.hpp"

#include "Core/Logger.hpp"
#include "Core/Charset.hpp"
#include "Core/HashFactory.hpp"

#include "OpenCL/Program.hpp"
#include "OpenCL/Kernel.hpp"
#include "OpenCL/Device.hpp"

namespace HonoursProject
{
    BruteforceSetupTask::BruteforceSetupTask(std::vector<std::string> input, std::shared_ptr<HashFactory> hash_factory)
        : input(input), hash_factory(hash_factory)
    {
    }

    BruteforceSetupTask::~BruteforceSetupTask()
    {
    }

    bool BruteforceSetupTask::run()
    {
        if (input.size() != 2)
        {
            return false;
        }

        charsets = Charset::Create(input[1]);

        if (!charsets.size())
        {
            Logger::error("Error: Invalid charset!\n");

            return false;
        }

        total_batch_size = Charset::GetTotalMsgNum(charsets);

        if (charsets.size() < 6)
        {
            msg_prefix_size = 1;
        }
        else if (charsets.size() < 8)
        {
            msg_prefix_size = 2;
        }
        else if (charsets.size() < 10)
        {
            msg_prefix_size = 3;
        }
        else
        {
            msg_prefix_size = 4;
        }

        message_size = charsets.size();

        msg_suffix_size = message_size - msg_prefix_size;

        inner_loop_size = static_cast<uint32_t>(Charset::GetTotalMsgNum(charsets, msg_prefix_size));

        total_batch_size /= inner_loop_size;

        Logger::info("Attack.Type: ............: Bruteforce\n", message_size);
        Logger::info("Message.Length: .........: %d + %d = %d characters\n", msg_prefix_size, msg_suffix_size, message_size);
        Logger::info("Message.Batch: ..........: %ul x %ul\n", inner_loop_size, total_batch_size);

        for (std::size_t digest_pos = 0; digest_pos < 1; digest_pos++)
        {
            std::vector<std::uint32_t> result = hash_factory->parse(input[0]);

            std::copy(result.begin(), result.end(), std::back_inserter(msg_dgst));
        }

        return true;
    }

    std::vector<Charset> BruteforceSetupTask::getCharsets()
    {
        return charsets;
    }
    std::uint32_t BruteforceSetupTask::getMessageSize()
    {
        return message_size;
    }

    std::uint32_t BruteforceSetupTask::getMessagePrefix()
    {
        return msg_prefix_size;
    }

    std::uint32_t BruteforceSetupTask::getMessageSuffix()
    {
        return msg_suffix_size;
    }
}

