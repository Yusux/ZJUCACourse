// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Thu Dec  7 16:31:57 2023
// Host        : YusuxYT running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/flyme/Documents/Course/Vivado/Arch/arch-fa23/src/lab4/Exp4_NEXYS_A7/Exp4.gen/sources_1/ip/ROM_D/ROM_D_sim_netlist.v
// Design      : ROM_D
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "ROM_D,dist_mem_gen_v8_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module ROM_D
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
  ROM_D_dist_mem_gen_v8_0_13 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 11056)
`pragma protect data_block
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
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
