## 绝对导入
```
sound/                          Top-level package
      __init__.py               Initialize the sound package
      formats/                  Subpackage for file format conversions
              __init__.py
              wavread.py
              wavwrite.py
              aiffread.py
              aiffwrite.py
              auread.py
              auwrite.py
              ...
      effects/                  Subpackage for sound effects
              __init__.py
              echo.py
              surround.py
              reverse.py
              ...
      filters/                  Subpackage for filters
              __init__.py
              equalizer.py
              vocoder.py
              karaoke.py
              ...
```
```py
import sound.effects.echo
# 使用import导入模块，使用时必须使用全名称
sound.effects.echo.echofilter(input, output, delay=0.7, atten=4)

from sound.effects import echo
# 使用from import导入模块，使用时只需要使用import后面的模块名
echo.echofilter(input, output, delay=0.7, atten=4)

from sound.effects.echo import echofilter
# 也可以使用from import直接导入模块内的函数，可以直接调用
echofilter(input, output, delay=0.7, atten=4)
```
假如文件```sound/effects/__init__.py```定义如下 ```__all__```列表（```__init__.py```另外一个功能就是做一些初始化操作）

```py
__all__ = ["echo", "surround", "reverse"]
```
后面使用```from sound.effects import *```导入包时，会导入```echo```，```surround```，```reverse```三个子模块。

如果```__all__```列表未定义,则不会从```sound.effects```导入子模块到命名空间，仅仅保证```sound.effects```被导入。

## 相对导入
相对导入的路径是相对于当前模块的路径，```.```表示当前路径，```..```表示上一级目录

```py
from . import echo
from .. import formats
from ..filters import equalizer
```
