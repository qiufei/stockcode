#!/bin/sh

# get source file updates
git pull

# save change
git add --all && git commit -a -m 'better' && git push

# finally
echo "所有股票代码已经更新。well done!"  
