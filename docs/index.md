# 浙江大学23年计算机体系结构实验

本[仓库](https://git.zju.edu.cn/zju-arch/arch-fa23)是浙江大学23年秋**计算机体系结构**课程的教学仓库，包含所有实验文档和公开代码。目录结构：

```bash
├── README.md
├── docs/       # 实验文档   
├── mkdocs.yml
└── src/        # 公开代码
```

实验文档已经部署在了[zju-git pages](https://zju-arch.pages.zjusct.io/arch-fa23)上，方便大家阅读。


## 本地渲染文档

文档采用了 [mkdocs-material](https://squidfunk.github.io/mkdocs-material/) 工具构建和部署。如果想在本地渲染：

```bash
$ pip3 install mkdocs-material                      # 安装 mkdocs-material
$ git clone https://git.zju.edu.cn/zju-arch/arch-fa23 # clone 本 repo
$ mkdocs serve                                      # 本地渲染
INFO     -  Building documentation...
INFO     -  Cleaning site directory
...
INFO     -  [11:00:57] Serving on http://127.0.0.1:8000/arch-fa23/
```

