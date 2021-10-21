import re
import os

os.chdir('/cloud/project/txt_cleaner/')

author = "dazai"

_dir = "./data/row/NORUBY/{}/".format(author)
_out_dir = "./data/fixed/{}/".format(author)

fs = os.listdir(_dir)

for f in fs:
  with open(_dir + f, "r") as fh:
    txt = fh.read()
  
  txt = txt.replace("\n", "")
  txt = txt.replace("\u3000", "")
  split_txt = re.findall(".*?。", txt)
  join_txt = "\n".join(split_txt)
  
  with open(_out_dir + f, "w", encoding="UTF-8") as fh:
    fh.write(join_txt)
