void crack_md5(
    u32 w[16], 
    __global struct message_prefix_t* msg_prefix,
    __global struct message_index_t* msg_index,
    __global struct message_digest_t* msg_digest,
    const u32 msg_batch_pos,
    const u32 inner_loop_size)
{
    const u32 F_w0c00 = 0     + MD5_K_01;
    const u32 F_w1c01 = w[ 1] + MD5_K_02;
    const u32 F_w2c02 = w[ 2] + MD5_K_03;
    const u32 F_w3c03 = w[ 3] + MD5_K_04;
    const u32 F_w4c04 = w[ 4] + MD5_K_05;
    const u32 F_w5c05 = w[ 5] + MD5_K_06;
    const u32 F_w6c06 = w[ 6] + MD5_K_07;
    const u32 F_w7c07 = w[ 7] + MD5_K_08;
    const u32 F_w8c08 = w[ 8] + MD5_K_09;
    const u32 F_w9c09 = w[ 9] + MD5_K_10;
    const u32 F_wac0a = w[10] + MD5_K_11;
    const u32 F_wbc0b = w[11] + MD5_K_12;
    const u32 F_wcc0c = w[12] + MD5_K_13;
    const u32 F_wdc0d = w[13] + MD5_K_14;
    const u32 F_wec0e = w[14] + MD5_K_15;
    const u32 F_wfc0f = w[15] + MD5_K_16;

    const u32 G_w1c10 = w[ 1] + MD5_K_17;
    const u32 G_w6c11 = w[ 6] + MD5_K_18;
    const u32 G_wbc12 = w[11] + MD5_K_19;
    const u32 G_w0c13 = 0     + MD5_K_20;
    const u32 G_w5c14 = w[ 5] + MD5_K_21;
    const u32 G_wac15 = w[10] + MD5_K_22;
    const u32 G_wfc16 = w[15] + MD5_K_23;
    const u32 G_w4c17 = w[ 4] + MD5_K_24;
    const u32 G_w9c18 = w[ 9] + MD5_K_25;
    const u32 G_wec19 = w[14] + MD5_K_26;
    const u32 G_w3c1a = w[ 3] + MD5_K_27;
    const u32 G_w8c1b = w[ 8] + MD5_K_28;
    const u32 G_wdc1c = w[13] + MD5_K_29;
    const u32 G_w2c1d = w[ 2] + MD5_K_30;
    const u32 G_w7c1e = w[ 7] + MD5_K_31;
    const u32 G_wcc1f = w[12] + MD5_K_32;

    const u32 H_w5c20 = w[ 5] + MD5_K_33;
    const u32 H_w8c21 = w[ 8] + MD5_K_34;
    const u32 H_wbc22 = w[11] + MD5_K_35;
    const u32 H_wec23 = w[14] + MD5_K_36;
    const u32 H_w1c24 = w[ 1] + MD5_K_37;
    const u32 H_w4c25 = w[ 4] + MD5_K_38;
    const u32 H_w7c26 = w[ 7] + MD5_K_39;
    const u32 H_wac27 = w[10] + MD5_K_40;
    const u32 H_wdc28 = w[13] + MD5_K_41;
    const u32 H_w0c29 = 0     + MD5_K_42;
    const u32 H_w3c2a = w[ 3] + MD5_K_43;
    const u32 H_w6c2b = w[ 6] + MD5_K_44;
    const u32 H_w9c2c = w[ 9] + MD5_K_45;
    const u32 H_wcc2d = w[12] + MD5_K_46;
    const u32 H_wfc2e = w[15] + MD5_K_47;
    const u32 H_w2c2f = w[ 2] + MD5_K_48;

    const u32 I_w0c30 = 0     + MD5_K_49;
    const u32 I_w7c31 = w[ 7] + MD5_K_50;
    const u32 I_wec32 = w[14] + MD5_K_51;
    const u32 I_w5c33 = w[ 5] + MD5_K_52;
    const u32 I_wcc34 = w[12] + MD5_K_53;
    const u32 I_w3c35 = w[ 3] + MD5_K_54;
    const u32 I_wac36 = w[10] + MD5_K_55;
    const u32 I_w1c37 = w[ 1] + MD5_K_56;
    const u32 I_w8c38 = w[ 8] + MD5_K_57;
    const u32 I_wfc39 = w[15] + MD5_K_58;
    const u32 I_w6c3a = w[ 6] + MD5_K_59;
    const u32 I_wdc3b = w[13] + MD5_K_60;
    const u32 I_w4c3c = w[ 4] + MD5_K_61;
    const u32 I_wbc3d = w[11] + MD5_K_62;
    const u32 I_w2c3e = w[ 2] + MD5_K_63;
    const u32 I_w9c3f = w[ 9] + MD5_K_64;

    const u32 search[4] =
    {
        msg_digest[0].data[DIGEST_INDEX_0],
        msg_digest[0].data[DIGEST_INDEX_1],
        msg_digest[0].data[DIGEST_INDEX_2],
        msg_digest[0].data[DIGEST_INDEX_3]
    };

    u32 a_rev = msg_digest[0].data[0];
    u32 b_rev = msg_digest[0].data[1];
    u32 c_rev = msg_digest[0].data[2];
    u32 d_rev = msg_digest[0].data[3];

    MD5_STEP_REV(MD5_I, b_rev, c_rev, d_rev, a_rev, w[ 9], MD5_K_64, MD5_ROUND_4_SHIFT_4);      /* 64 */
    MD5_STEP_REV(MD5_I, c_rev, d_rev, a_rev, b_rev, w[ 2], MD5_K_63, MD5_ROUND_4_SHIFT_3);      /* 63 */
    MD5_STEP_REV(MD5_I, d_rev, a_rev, b_rev, c_rev, w[11], MD5_K_62, MD5_ROUND_4_SHIFT_2);      /* 62 */
    MD5_STEP_REV(MD5_I, a_rev, b_rev, c_rev, d_rev, w[ 4], MD5_K_61, MD5_ROUND_4_SHIFT_1);      /* 61 */
    MD5_STEP_REV(MD5_I, b_rev, c_rev, d_rev, a_rev, w[13], MD5_K_60, MD5_ROUND_4_SHIFT_4);      /* 60 */
    MD5_STEP_REV(MD5_I, c_rev, d_rev, a_rev, b_rev, w[ 6], MD5_K_59, MD5_ROUND_4_SHIFT_3);      /* 59 */
    MD5_STEP_REV(MD5_I, d_rev, a_rev, b_rev, c_rev, w[15], MD5_K_58, MD5_ROUND_4_SHIFT_2);      /* 58 */
    MD5_STEP_REV(MD5_I, a_rev, b_rev, c_rev, d_rev, w[ 8], MD5_K_57, MD5_ROUND_4_SHIFT_1);      /* 57 */
    MD5_STEP_REV(MD5_I, b_rev, c_rev, d_rev, a_rev, w[ 1], MD5_K_56, MD5_ROUND_4_SHIFT_4);      /* 56 */
    MD5_STEP_REV(MD5_I, c_rev, d_rev, a_rev, b_rev, w[10], MD5_K_55, MD5_ROUND_4_SHIFT_3);      /* 55 */
    MD5_STEP_REV(MD5_I, d_rev, a_rev, b_rev, c_rev, w[ 3], MD5_K_54, MD5_ROUND_4_SHIFT_2);      /* 54 */
    MD5_STEP_REV(MD5_I, a_rev, b_rev, c_rev, d_rev, w[12], MD5_K_53, MD5_ROUND_4_SHIFT_1);      /* 53 */
    MD5_STEP_REV(MD5_I, b_rev, c_rev, d_rev, a_rev, w[ 5], MD5_K_52, MD5_ROUND_4_SHIFT_4);      /* 52 */
    MD5_STEP_REV(MD5_I, c_rev, d_rev, a_rev, b_rev, w[14], MD5_K_51, MD5_ROUND_4_SHIFT_3);      /* 51 */
    MD5_STEP_REV(MD5_I, d_rev, a_rev, b_rev, c_rev, w[ 7], MD5_K_50, MD5_ROUND_4_SHIFT_2);      /* 50 */
    MD5_STEP_REV(MD5_I, a_rev, b_rev, c_rev, d_rev, 0    , MD5_K_49, MD5_ROUND_4_SHIFT_1);      /* 49 */

    const u32 pre_cd = c_rev ^ d_rev;

    MD5_STEP_REV1(MD5_H, b_rev, c_rev, d_rev, a_rev, w[ 2], MD5_K_48, MD5_ROUND_3_SHIFT_4);     /* 48 */
    MD5_STEP_REV1(MD5_H, c_rev, d_rev, a_rev, b_rev, w[15], MD5_K_47, MD5_ROUND_3_SHIFT_3);     /* 47 */

    u32 w0_init = w[0];

    for (u32 inner_loop_pos = 0; inner_loop_pos < inner_loop_size; inner_loop_pos += VECTOR_SIZE)
    {
        const u32x w0_next = msg_prefix[inner_loop_pos / VECTOR_SIZE].data;

        const u32x w0 = w0_init | w0_next;

        const u32x pre_d = d_rev;
        const u32x pre_a = a_rev - w0;
        const u32x pre_b = b_rev - (pre_a ^ pre_cd);
        const u32x pre_c = c_rev - (pre_a ^ pre_b ^ pre_d);

        u32x a = MD5_DIGEST_A;
        u32x b = MD5_DIGEST_B;
        u32x c = MD5_DIGEST_C;
        u32x d = MD5_DIGEST_D;

        MD5_STEP(MD5_F, a, b, c, d, w0, F_w0c00, MD5_ROUND_1_SHIFT_1);      /*  1= */
        MD5_STEP_FAST(MD5_F, d, a, b, c, F_w1c01, MD5_ROUND_1_SHIFT_2);     /*  2 */
        MD5_STEP_FAST(MD5_F, c, d, a, b, F_w2c02, MD5_ROUND_1_SHIFT_3);     /*  3 */
        MD5_STEP_FAST(MD5_F, b, c, d, a, F_w3c03, MD5_ROUND_1_SHIFT_4);     /*  4 */
        MD5_STEP_FAST(MD5_F, a, b, c, d, F_w4c04, MD5_ROUND_1_SHIFT_1);     /*  5 */
        MD5_STEP_FAST(MD5_F, d, a, b, c, F_w5c05, MD5_ROUND_1_SHIFT_2);     /*  6 */
        MD5_STEP_FAST(MD5_F, c, d, a, b, F_w6c06, MD5_ROUND_1_SHIFT_3);     /*  7 */
        MD5_STEP_FAST(MD5_F, b, c, d, a, F_w7c07, MD5_ROUND_1_SHIFT_4);     /*  8 */
        MD5_STEP_FAST(MD5_F, a, b, c, d, F_w8c08, MD5_ROUND_1_SHIFT_1);     /*  9 */
        MD5_STEP_FAST(MD5_F, d, a, b, c, F_w9c09, MD5_ROUND_1_SHIFT_2);     /* 10 */
        MD5_STEP_FAST(MD5_F, c, d, a, b, F_wac0a, MD5_ROUND_1_SHIFT_3);     /* 11 */
        MD5_STEP_FAST(MD5_F, b, c, d, a, F_wbc0b, MD5_ROUND_1_SHIFT_4);     /* 12 */
        MD5_STEP_FAST(MD5_F, a, b, c, d, F_wcc0c, MD5_ROUND_1_SHIFT_1);     /* 13 */
        MD5_STEP_FAST(MD5_F, d, a, b, c, F_wdc0d, MD5_ROUND_1_SHIFT_2);     /* 14 */
        MD5_STEP_FAST(MD5_F, c, d, a, b, F_wec0e, MD5_ROUND_1_SHIFT_3);     /* 15 */
        MD5_STEP_FAST(MD5_F, b, c, d, a, F_wfc0f, MD5_ROUND_1_SHIFT_4);     /* 16 */

        MD5_STEP_FAST(MD5_G, a, b, c, d, G_w1c10, MD5_ROUND_2_SHIFT_1);     /* 17 */
        MD5_STEP_FAST(MD5_G, d, a, b, c, G_w6c11, MD5_ROUND_2_SHIFT_2);     /* 18 */
        MD5_STEP_FAST(MD5_G, c, d, a, b, G_wbc12, MD5_ROUND_2_SHIFT_3);     /* 19 */
        MD5_STEP(MD5_G, b, c, d, a, w0, G_w0c13, MD5_ROUND_2_SHIFT_4);      /* 20= */
        MD5_STEP_FAST(MD5_G, a, b, c, d, G_w5c14, MD5_ROUND_2_SHIFT_1);     /* 21 */
        MD5_STEP_FAST(MD5_G, d, a, b, c, G_wac15, MD5_ROUND_2_SHIFT_2);     /* 22 */
        MD5_STEP_FAST(MD5_G, c, d, a, b, G_wfc16, MD5_ROUND_2_SHIFT_3);     /* 23 */
        MD5_STEP_FAST(MD5_G, b, c, d, a, G_w4c17, MD5_ROUND_2_SHIFT_4);     /* 24 */
        MD5_STEP_FAST(MD5_G, a, b, c, d, G_w9c18, MD5_ROUND_2_SHIFT_1);     /* 25 */
        MD5_STEP_FAST(MD5_G, d, a, b, c, G_wec19, MD5_ROUND_2_SHIFT_2);     /* 26 */
        MD5_STEP_FAST(MD5_G, c, d, a, b, G_w3c1a, MD5_ROUND_2_SHIFT_3);     /* 27 */
        MD5_STEP_FAST(MD5_G, b, c, d, a, G_w8c1b, MD5_ROUND_2_SHIFT_4);     /* 28 */
        MD5_STEP_FAST(MD5_G, a, b, c, d, G_wdc1c, MD5_ROUND_2_SHIFT_1);     /* 29 */
        MD5_STEP_FAST(MD5_G, d, a, b, c, G_w2c1d, MD5_ROUND_2_SHIFT_2);     /* 30 */
        MD5_STEP_FAST(MD5_G, c, d, a, b, G_w7c1e, MD5_ROUND_2_SHIFT_3);     /* 31 */
        MD5_STEP_FAST(MD5_G, b, c, d, a, G_wcc1f, MD5_ROUND_2_SHIFT_4);     /* 32 */

        MD5_STEP_FAST(MD5_H, a, b, c, d, H_w5c20, MD5_ROUND_3_SHIFT_1);      /* 33 */
        MD5_STEP_FAST(MD5_H, d, a, b, c, H_w8c21, MD5_ROUND_3_SHIFT_2);      /* 34 */
        MD5_STEP_FAST(MD5_H, c, d, a, b, H_wbc22, MD5_ROUND_3_SHIFT_3);      /* 35 */
        MD5_STEP_FAST(MD5_H, b, c, d, a, H_wec23, MD5_ROUND_3_SHIFT_4);      /* 36 */
        MD5_STEP_FAST(MD5_H, a, b, c, d, H_w1c24, MD5_ROUND_3_SHIFT_1);      /* 37 */
        MD5_STEP_FAST(MD5_H, d, a, b, c, H_w4c25, MD5_ROUND_3_SHIFT_2);      /* 38 */
        MD5_STEP_FAST(MD5_H, c, d, a, b, H_w7c26, MD5_ROUND_3_SHIFT_3);      /* 39 */
        MD5_STEP_FAST(MD5_H, b, c, d, a, H_wac27, MD5_ROUND_3_SHIFT_4);      /* 40 */
        MD5_STEP_FAST(MD5_H, a, b, c, d, H_wdc28, MD5_ROUND_3_SHIFT_1);      /* 41 */
        MD5_STEP(MD5_H, d, a, b, c, w0, H_w0c29, MD5_ROUND_3_SHIFT_2);       /* 42= */
        MD5_STEP_FAST(MD5_H, c, d, a, b, H_w3c2a, MD5_ROUND_3_SHIFT_3);      /* 43 */

        if (NOT_EQUAL_VECTOR(pre_c,c)) continue;

        MD5_STEP_FAST(MD5_H, b, c, d, a, H_w6c2b, MD5_ROUND_3_SHIFT_4);      /* 44 */
        MD5_STEP_FAST(MD5_H, a, b, c, d, H_w9c2c, MD5_ROUND_3_SHIFT_1);      /* 45 */
        MD5_STEP_FAST(MD5_H, d, a, b, c, H_wcc2d, MD5_ROUND_3_SHIFT_2);      /* 46 */

        if (NOT_EQUAL_VECTOR(pre_d,d)) continue;

        MD5_STEP_FAST(MD5_H, c, d, a, b, H_wfc2e, MD5_ROUND_3_SHIFT_3);      /* 47 */
        MD5_STEP_FAST(MD5_H, b, c, d, a, H_w2c2f, MD5_ROUND_3_SHIFT_4);      /* 48 */

        MD5_STEP(MD5_I, a, b, c, d, w0, I_w0c30, MD5_ROUND_4_SHIFT_1);       /* 49= */
        MD5_STEP_FAST(MD5_I, d, a, b, c, I_w7c31, MD5_ROUND_4_SHIFT_2);      /* 50 */
        MD5_STEP_FAST(MD5_I, c, d, a, b, I_wec32, MD5_ROUND_4_SHIFT_3);      /* 51 */
        MD5_STEP_FAST(MD5_I, b, c, d, a, I_w5c33, MD5_ROUND_4_SHIFT_4);      /* 52 */
        MD5_STEP_FAST(MD5_I, a, b, c, d, I_wcc34, MD5_ROUND_4_SHIFT_1);      /* 53 */
        MD5_STEP_FAST(MD5_I, d, a, b, c, I_w3c35, MD5_ROUND_4_SHIFT_2);      /* 54 */
        MD5_STEP_FAST(MD5_I, c, d, a, b, I_wac36, MD5_ROUND_4_SHIFT_3);      /* 55 */
        MD5_STEP_FAST(MD5_I, b, c, d, a, I_w1c37, MD5_ROUND_4_SHIFT_4);      /* 56 */
        MD5_STEP_FAST(MD5_I, a, b, c, d, I_w8c38, MD5_ROUND_4_SHIFT_1);      /* 57 */
        MD5_STEP_FAST(MD5_I, d, a, b, c, I_wfc39, MD5_ROUND_4_SHIFT_2);      /* 58 */
        MD5_STEP_FAST(MD5_I, c, d, a, b, I_w6c3a, MD5_ROUND_4_SHIFT_3);      /* 59 */
        MD5_STEP_FAST(MD5_I, b, c, d, a, I_wdc3b, MD5_ROUND_4_SHIFT_4);      /* 60 */
        MD5_STEP_FAST(MD5_I, a, b, c, d, I_w4c3c, MD5_ROUND_4_SHIFT_1);      /* 61 */

        if (NOT_EQUAL_SCALAR(a,search[0])) continue;

        MD5_STEP_FAST(MD5_I, d, a, b, c, I_wbc3d, MD5_ROUND_4_SHIFT_2);      /* 62 */
        MD5_STEP_FAST(MD5_I, c, d, a, b, I_w2c3e, MD5_ROUND_4_SHIFT_3);      /* 63 */
        MD5_STEP_FAST(MD5_I, b, c, d, a, I_w9c3f, MD5_ROUND_4_SHIFT_4);      /* 64 */
       
        COMPARE_DIGEST(a, d, c, b);
    }
}

__kernel void hash_crack_4(
    __global struct message_t* msg,
    __global struct message_prefix_t* msg_prefix,
    __global struct message_index_t* msg_index,
    __global struct message_digest_t* msg_digest,
    const u32 inner_loop_size,
    const u32 msg_batch_size)
{
    const u32 msg_batch_pos = get_global_id(0);

    if (msg_batch_pos >= msg_batch_size) return;
  
    u32 w[16];

    w[0] = msg[msg_batch_pos].data[0];
    w[1] = msg[msg_batch_pos].data[1];
    w[2] = msg[msg_batch_pos].data[2];
    w[3] = msg[msg_batch_pos].data[3];
    w[4] = 0;
    w[5] = 0;
    w[6] = 0;
    w[7] = 0;
    w[8] = 0;
    w[9] = 0;
    w[10] = 0;
    w[11] = 0;
    w[12] = 0;
    w[13] = 0;
    w[14] = msg[msg_batch_pos].data[14];
    w[15] = 0;

    const u32 pw_len = msg[msg_batch_pos].size;

    crack_md5(w, msg_prefix, msg_index, msg_digest, msg_batch_pos, inner_loop_size);
}

__kernel void hash_crack_8(
    __global struct message_t* msg,
    __global struct message_prefix_t* msg_prefix,
    __global struct message_index_t* msg_index,
    __global struct message_digest_t* msg_digest,
    const u32 inner_loop_size,
    const u32 msg_batch_size)
{
    const u32 msg_batch_pos = get_global_id(0);

    if (msg_batch_pos >= msg_batch_size) return;

    u32 w[16];

    w[0] = msg[msg_batch_pos].data[0];
    w[1] = msg[msg_batch_pos].data[1];
    w[2] = msg[msg_batch_pos].data[2];
    w[3] = msg[msg_batch_pos].data[3];
    w[4] = msg[msg_batch_pos].data[4];
    w[5] = msg[msg_batch_pos].data[5];
    w[6] = msg[msg_batch_pos].data[6];
    w[7] = msg[msg_batch_pos].data[7];
    w[8] = 0;
    w[9] = 0;
    w[10] = 0;
    w[11] = 0;
    w[12] = 0;
    w[13] = 0;
    w[14] = msg[msg_batch_pos].data[14];
    w[15] = 0;

    const u32 pw_len = msg[msg_batch_pos].size;

    crack_md5(w, msg_prefix, msg_index, msg_digest, msg_batch_pos, inner_loop_size);
}

__kernel void hash_crack_16(
    __global struct message_t* msg,
    __global struct message_prefix_t* msg_prefix,
    __global struct message_index_t* msg_index,
    __global struct message_digest_t* msg_digest,
    const u32 inner_loop_size,
    const u32 msg_batch_size)
{
    const u32 msg_batch_pos = get_global_id(0);

    if (msg_batch_pos >= msg_batch_size) return;

    u32 w[16];

    w[0] = msg[msg_batch_pos].data[0];
    w[1] = msg[msg_batch_pos].data[1];
    w[2] = msg[msg_batch_pos].data[2];
    w[3] = msg[msg_batch_pos].data[3];
    w[4] = msg[msg_batch_pos].data[4];
    w[5] = msg[msg_batch_pos].data[5];
    w[6] = msg[msg_batch_pos].data[6];
    w[7] = msg[msg_batch_pos].data[7];
    w[8] = msg[msg_batch_pos].data[8];
    w[9] = msg[msg_batch_pos].data[9];
    w[10] = msg[msg_batch_pos].data[10];
    w[11] = msg[msg_batch_pos].data[11];
    w[12] = msg[msg_batch_pos].data[12];
    w[13] = msg[msg_batch_pos].data[13];
    w[14] = msg[msg_batch_pos].data[14];
    w[15] = msg[msg_batch_pos].data[15];

    const u32 pw_len = msg[msg_batch_pos].size;

    crack_md5(w, msg_prefix, msg_index, msg_digest, msg_batch_pos, inner_loop_size);
}
