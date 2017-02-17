#!/bin/sh
# get into operation folder
cd stockcode

# get source file updates
git pull

# get quandl code
Rscript  get-google-finance-codes.r && echo "hello data!"

# save change
git add --all && git commit -a -m 'better' && git push

# finally
echo "所有股票代码已经更新。well done!"  
