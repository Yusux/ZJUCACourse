// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Thu Dec  7 16:31:56 2023
// Host        : YusuxYT running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ ROM_D_sim_netlist.v
// Design      : ROM_D
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "ROM_D,dist_mem_gen_v8_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (a,
    spo);
  input [9:0]a;
  output [31:0]spo;

  wire \<const0> ;
  wire [9:0]a;
  wire [31:0]\^spo ;
  wire [31:0]NLW_U0_dpo_UNCONNECTED;
  wire [31:0]NLW_U0_qdpo_UNCONNECTED;
  wire [31:0]NLW_U0_qspo_UNCONNECTED;
  wire [21:21]NLW_U0_spo_UNCONNECTED;

  assign spo[31:22] = \^spo [31:22];
  assign spo[21] = \<const0> ;
  assign spo[20:0] = \^spo [20:0];
  GND GND
       (.G(\<const0> ));
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_D = "0" *) 
  (* C_HAS_DPO = "0" *) 
  (* C_HAS_DPRA = "0" *) 
  (* C_HAS_I_CE = "0" *) 
  (* C_HAS_QDPO = "0" *) 
  (* C_HAS_QDPO_CE = "0" *) 
  (* C_HAS_QDPO_CLK = "0" *) 
  (* C_HAS_QDPO_RST = "0" *) 
  (* C_HAS_QDPO_SRST = "0" *) 
  (* C_HAS_WE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_PIPELINE_STAGES = "0" *) 
  (* C_QCE_JOINED = "0" *) 
  (* C_QUALIFY_WE = "0" *) 
  (* C_REG_DPRA_INPUT = "0" *) 
  (* c_addr_width = "10" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "1024" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_clk = "0" *) 
  (* c_has_qspo = "0" *) 
  (* c_has_qspo_ce = "0" *) 
  (* c_has_qspo_rst = "0" *) 
  (* c_has_qspo_srst = "0" *) 
  (* c_has_spo = "1" *) 
  (* c_mem_init_file = "ROM_D.mif" *) 
  (* c_parser_type = "1" *) 
  (* c_read_mif = "1" *) 
  (* c_reg_a_d_inputs = "0" *) 
  (* c_sync_enable = "1" *) 
  (* c_width = "32" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_dist_mem_gen_v8_0_13 U0
       (.a(a),
        .clk(1'b0),
        .d({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dpo(NLW_U0_dpo_UNCONNECTED[31:0]),
        .dpra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .i_ce(1'b1),
        .qdpo(NLW_U0_qdpo_UNCONNECTED[31:0]),
        .qdpo_ce(1'b1),
        .qdpo_clk(1'b0),
        .qdpo_rst(1'b0),
        .qdpo_srst(1'b0),
        .qspo(NLW_U0_qspo_UNCONNECTED[31:0]),
        .qspo_ce(1'b1),
        .qspo_rst(1'b0),
        .qspo_srst(1'b0),
        .spo(\^spo ),
        .we(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
M9ERyrMNmk2Jjyg6ZCGYQpTqx5C+74+ICn/vAQ5KoRuxJNbql8tHJjFcOe3FAJX14Nokq4wtfvZP
2sPXAs/eYYzjjbnt4nx8oZRRPy0XyDpvba/qxyqBSxjChIoPMDwpXnxi+chZJU5N1zCNt9FZPAep
nLCjMCkQTlKbP3cUJIY=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
FBAg02qOh8M8uZkNvwWHoY3ELncwvHjjgL2y2qLN7xuxxaPQj3LdyD/IETTPdSjNCB/rhpJxbT1y
U5fbF28Hkp+bzDuxeTWPX251wMhiEmdm4jhyMl2z+GRf2Z6VJ4bVM5bieaJvsbjuyQ9Az6TDmueI
14citDEbyRCyJD9EiVckdS2mZcTl37oVFebKnIeJGmNjOc2XrcM84JVJIG5iv3ryS2hAG9/84hEr
u3DYC+xS2w5swJXVSf0zV+w8xZulS3PTPLELIM8O+SEFdHetZKnrgG1aJ7V5xu0RniGAsyVwVbgu
M1jPqNLyU+9kyETKfG9jcGEIM2I2gUfmOvRs+g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
TYvdYOtu2OcY/hp0LCFlgwGgJeLJ5MSBDPjuyI3760LiXtklDVs7CUFlvRRXMgAzbHlMXbiHp/Xl
cvmN035ayt8D8gPWRXxnbQf3kRlW6EIFwFMZ1inL9b5f47gsuvCP6MaKiTg0W7+/ZeHbM4jHXvRe
b8HXvQvK5kVwtayEwt0=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
GkcGg32vdV7ZS9x4Uw9v3hZEcxD5hMmQXUqa6shDPbzqUGIxrKpTOb9W4Sgi8rq+qw7QpAZp2JW/
MkYAH1WikFlf+XWG57y55EFV7oRoKQDh2Yz0sZEwVhwTGwSAqfnjrmPITofdG5eiey1ySGprEKsT
mqWAV+ZN7TkQkKup0Ukf1O+8giYKT/7UibTRqG/CT9dgU/4atPgYh2QjNMVrsAH/uzDxh7stQMYe
nkjZBkpLWOq7mxEXTKVtYAD/8G5qCJELRcvCuUKYz4Une1wDj+L/vwRK3IAdWKQ+/5mvj0q5XEm7
IKu5HYvalbySwRWzaB00uobXZorNhfwSv45jHg==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
JnT3Bfv/DUBx2mIm4+jpmHjzhKoX4mNpcc/lgscv3iYrJw8Uble396hMwPsVZ+kkAsmYtegNCiTG
Z7kqnoNeWHv+Grdizsq0QM9S2KJ5EoZhjelE+3Cii/ztNHf7Y3c0nBPnioUQ5YmWk7vgoQl3SJ3d
vwD3G0c+fGJBRpi14hTJOB2wtu4EeWcJ1f+01LjKINeucLlwacjnN0tElyRgCNKfsRDAQiMqwKqg
XCleeNY0cyLXGI30pXMpnbLizYlNKgVD6DSeNaby0dhW4phR0a+9xteo8l8eRVzTO+VSOcYSy8rU
6Uj2y0Up19vcq91C+/YeHlh24VwNI2TJeUEDwQ==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
AWr8D+IaT/X0jMJSrwmWnhWOjt0+8oyULINYaH7QGBLgqKCVtf8rqo68R3/TZ8gTkN73fZOx0QCU
3WEp7Ga1gUsqEgy+2zGlncYhOzx62FJm4Pm7S6LbE1qdg3/9Pp55JLaf1ouYlZccQJ+yawj0HgL4
zR0T347Zg2aIFxQZ28icCuJbxAZsZgAT30scXsTMMvXlQQ9NI21OjirKgHRn3dldIjpkL+BrVBkQ
Q7MMiTBhpCn/c+WXk4H9BPc3vMrVoh6r5oo+e1858Hk7osyxNI9zuACaGwdAatsW756kQBMsQoUj
TmJksSfucjrHVSuLFffpztOARH3LXrhZcCZdoQ==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
fPVwMHnHe1L8weZTnbBxjlAabwZZnO4DZSHaO7tHGHAw6U+w+7Rc3BwfQXtiTyGXP15rvoLhvVpo
i1Tzs4zrV1X8vlWrxhS6XA2VO4RFkpCjmnHpvdgnW9mpk7w90QOEZIWZQST/o15t0wDT/kv4J36r
Ho59mVFCGQQSSYx0209u6sG2rNpJ5HtWMM+tDEDHUArucrBmPOoZSq0VSQsTHtjJQxr3U5fv9l6q
aEBWkjnLJ6zqLkt12B3q7V3iFORPpz6XNMqA6wzArzWirzgTCw3CduiSAgbNgoGmV4eNrVb2DfOT
5V4ni19GigMG1fHCD9dNPWGiRCWpY6iiN6iE1w==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
NkQB16Pku9sdGFuAkY+DjFhWzKYvb26AsK/VO1//MS5ztnK+V9d/0K8nVee9kGDNC4zorSd1NjRc
Jkj/JJm1k/9QiQQwOSB/94zKWUyVH2Rvw3UOuaTu9pWRQsIdmPNwXBKCOF5L17HHGaNqYzvHF7YY
REIp6VR4HcyLq2beYXn09Mq0f84obUr7+CMgh8i1SaLa/ydMPS9xsm1i0NFB3qcEC0dDq6xklwsX
s198UBI5mBJTEUKi38eytWXzQPFTmqdlD3Qn4CgstxSdoLrFHchISqt+L62U4xU6aVyYXmVaeebF
I1F3MAXQZwZwGETW7RW9t/+3pJtkjPfPtdnqu/Sg+zP+vLjSV/NcONctKnTj86/z+TTehoSH8ccr
BsjV0PhAtR3+RTr3VGkKJoUNeE8yFQIHlES8UamuSNMh5XrbmcbFx22MZ9gLOa350ytm1N124jNF
V860l5gGbt/8NcGf8I3EVPrYblJ5ZLGsZkVg1cKBMUys1yMm6Ci2Mruc

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
JDELzo7luYHcwIl8sAAMR3hvm1tr+ZaD3VKTvYj1uwYFwuIPCkUfjVi8OMAgp3Hh/R1wDZSeoY7T
xpO0sKF9MsovKwwArnByLL8zZflfJIe5AmC+jE5a8qUxydp4liMdOypRTLu6U6EUYUwSj6VOR0Uj
deCoQCr/gVZ2GdNKF5sKZsGXZSvx1Wag70BiGs69qhgUvVVlpbqpNRSB0DR/2IuSKCHhkucLXiTk
zVS7zC7GiyNYE6l/Yu5Ov25Cl+lY5cMZkqKvIFm90UiTBNYk4No5ofXnH/E0rNcbydv0BvWDmgKt
NXVratbi0ztKLb27z2lw5ZZzXCihB41kx4VjqA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 11120)
`pragma protect data_block
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
jqqM2vY=
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
