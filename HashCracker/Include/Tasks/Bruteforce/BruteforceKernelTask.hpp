/**
    BruteforceKernelTask.hpp

    Project Name: HashCracker

    Copyright (c) 2017 University of the West of Scotland
    
    Authors: Ioan-Cristian Szabo <cristian.szabo@outlook.com>
*/

#pragma once

#include "Tasks/Task.hpp"

#include "Tasks/KernelTask.hpp"

namespace HonoursProject
{
    class HashCracker;
    class AttackTask;
    class Device;
    class HashFactory;
    class Kernel;

    class HASH_CRACKER_PUBLIC BruteforceKernelTask : public KernelTask
    {
    public:

        BruteforceKernelTask(std::shared_ptr<Device> device, std::shared_ptr<HashFactory> hash_factory);

        virtual ~BruteforceKernelTask();

        virtual void run() override;

        virtual void transfer(std::shared_ptr<BaseTask> task) override;

        MessageMask getMessageMask();

        std::shared_ptr<Kernel> getGenWordPrefixKernel();

        std::shared_ptr<Kernel> getGenWordSuffixKernel();

    protected:

        std::shared_ptr<Device> device;
        
        std::shared_ptr<HashFactory> hash_factory;

        MessageMask message_mask;

        std::uint32_t message_size;

        std::uint32_t msg_prefix_size;

        std::uint32_t msg_suffix_size;

        std::shared_ptr<Kernel> kernel_gen_word_prefix;

        std::shared_ptr<Kernel> kernel_gen_word_suffix;

    };
}
