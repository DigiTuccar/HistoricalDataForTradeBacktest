#!/bin/bash

TEMP_GITHUB_REPO_DIRECTORY=GH-HistoricalDataForTradeBacktest-NO-LFS
rm -rf $TEMP_GITHUB_REPO_DIRECTORY
rclone copy historical-data-for-back-tests/ $TEMP_GITHUB_REPO_DIRECTORY --multi-thread-streams=32 --exclude "/.git/**"
chown gitlab-runner:gitlab-runner $TEMP_GITHUB_REPO_DIRECTORY -R
cd $TEMP_GITHUB_REPO_DIRECTORY
git config --global --add safe.directory $(pwd)
rm .gitattributes
rm .git-config-template

echo "*.feather binary" >.gitattributes
git init
git branch -m main
echo "git init edildi"
git remote add origin https://github.com/DigiTuccar/HistoricalDataForTradeBacktest.git
#git remote add origin git@github.com:DigiTuccar/HistoricalDataForTradeBacktest.git
echo "git remote add origin https://github.com/DigiTuccar/HistoricalDataForTradeBacktest.git yapildi"
git config --local user.name "DigiTuccar Auto Updater"
git config --local user.email "auto-updater-system@digituccar.com"
git config credential.helper store
git config --local http.postBuffer 2147483648
git config --local ssh.postBuffer 2147483648



# AYAR EKLENDİ
git config core.bigFileThreshold 1m
git config core.compression 0
git config core.looseCompression 0
git config core.deltaBaseCacheLimit 2g
#git config core.fsmonitor true
killall -9 watchman
watchman watch .
cp .git/hooks/fsmonitor-watchman.sample .git/hooks/query-watchman
git config core.fsmonitor .git/hooks/query-watchman

git config core.packedGitWindowSize 2g

git config core.untrackedcache true
git config fastimport.unpackLimit 0
git config feature.manyFiles true
git config fsmonitor.allowRemote true
#git config gc.auto 0
git config gc.bigPackThreshold 0
git config pack.compression 0
git config pack.packSizeLimit 2g

mv README-Github-Repo-Updating-now.md README.md
git add *.json *.env .gitattributes .gitignore LICENSE .github .pre-commit-config.yaml internal-tools summarized-reports *.* --verbose
echo "git add *.json *.env README.md --verbose tamam"
git commit -am "Repo Current Version `date +%Y-%m-%d-%T`" --verbose
git push -u --force origin HEAD:main --verbose

###################################################
# Binance Part 1

git add binance/*-1d*.feather
git commit -m "Binance spot 1d Updated `date +%Y-%m-%d-%T`"

git add binance/*-4h*.feather
git commit -m "Binance spot 4h Updated `date +%Y-%m-%d-%T`"

git add binance/*-1h*.feather
git commit -m "Binance spot 1h Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Binance Part 2

git add binance/*-15m*.feather
git commit -m "Binance spot 15m Updated `date +%Y-%m-%d-%T`"

git add binance/[A-J]*-5m*.feather
git commit -m "Binance spot 5m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

git add binance/[K-Z]*-5m*.feather
git commit -m "Binance spot 5m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose


git add binance/[A-J]*-3m*.feather
git commit -m "Binance spot 3m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

git add binance/[K-Z]*-3m*.feather
git commit -m "Binance spot 3m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Binance Part 3
git add binance/[A-B]*-1m*.feather
git commit -m "Binance spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Binance Part 4
git add binance/[C-D]*-1m*.feather
git commit -m "Binance spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

git add binance/[E-F]*-1m*.feather
git commit -m "Binance spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Binance Part 5
git add binance/[G-M]*-1m*.feather
git commit -m "Binance spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Binance Part 5
git add binance/[N-R]*-1m*.feather
git commit -m "Binance spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Binance Part 6
git add binance/[S-Z]*-1m*.feather
git commit -m "Binance spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

git add binance/*.feather
git commit -m "Binance spot Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

###################################################
# Kucoin Part 1

git add kucoin/*-1d*.feather
git commit -m "Kucoin spot 1d Updated `date +%Y-%m-%d-%T`"

git add kucoin/*-4h*.feather
git commit -m "Kucoin spot 4h Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose


git add kucoin/*-1h*.feather
git commit -m "Kucoin spot 1h Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Kucoin Part 2

git add kucoin/*-15m*.feather
git commit -m "Kucoin spot 15m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

git add kucoin/[A-J]*-5m*.feather
git commit -m "Kucoin spot 5m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose


git add kucoin/[K-Z]*-5m*.feather
git commit -m "Kucoin spot 5m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Kucoin Part 3
git add kucoin/[A-B]*-3m*.feather
git commit -m "Kucoin spot 3m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Kucoin Part 4
git add kucoin/[C-F]*-3m*.feather
git commit -m "Kucoin spot 3m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Kucoin Part 5
git add kucoin/[G-M]*-3m*.feather
git commit -m "Kucoin spot 3m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Kucoin Part 5
git add kucoin/[N-R]*-3m*.feather
git commit -m "Kucoin spot 3m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Kucoin Part 6
git add kucoin/[S-Z]*-3m*.feather
git commit -m "Kucoin spot 3m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose


# Kucoin Part 7
git add kucoin/A*-1m*.feather
git commit -m "Kucoin spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

git add kucoin/B*-1m*.feather
git commit -m "Kucoin spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

git add kucoin/C*-1m*.feather
git commit -m "Kucoin spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

git add kucoin/D*-1m*.feather
git commit -m "Kucoin spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose


# Kucoin Part 8
git add kucoin/[E-F]*-1m*.feather
git commit -m "Kucoin spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

git add kucoin/[G-H]*-1m*.feather
git commit -m "Kucoin spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Kucoin Part 9
git add kucoin/[I-J]*-1m*.feather
git commit -m "Kucoin spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

git add kucoin/[K-L]*-1m*.feather
git commit -m "Kucoin spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

git add kucoin/[M-N]*-1m*.feather
git commit -m "Kucoin spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Kucoin Part 10
git add kucoin/[O-P]*-1m*.feather
git commit -m "Kucoin spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

git add kucoin/[Q-R]*-1m*.feather
git commit -m "Kucoin spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Kucoin Part 11
git add kucoin/[S-T]*-1m*.feather
git commit -m "Kucoin spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose


# Kucoin Part 11
git add kucoin/[U-V]*-1m*.feather
git commit -m "Kucoin spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

git add kucoin/[W-X]*-1m*.feather
git commit -m "Kucoin spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

git add kucoin/[Y-Z]*-1m*.feather
git commit -m "Kucoin spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

git add kucoin/*.feather
git commit -m "Kucoin spot Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

###################################################
# Okx Part 1

git add okx/*-1d*.feather
git commit -m "Okx spot 1d Updated `date +%Y-%m-%d-%T`"

git add okx/*-4h*.feather
git commit -m "Okx spot 4h Updated `date +%Y-%m-%d-%T`"

git add okx/*-1h*.feather
git commit -m "Okx spot 1h Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Okx Part 2

git add okx/*-15m*.feather
git commit -m "Okx spot 15m Updated `date +%Y-%m-%d-%T`"

git add okx/*-5m*.feather
git commit -m "Okx spot 5m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

git add okx/*-3m*.feather
git commit -m "Okx spot 3m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Okx Part 3
git add okx/[A-B]*-1m*.feather
git commit -m "Okx spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Okx Part 4
git add okx/[C-F]*-1m*.feather
git commit -m "Okx spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Okx Part 5
git add okx/[G-M]*-1m*.feather
git commit -m "Okx spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Okx Part 5
git add okx/[N-R]*-1m*.feather
git commit -m "Okx spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Okx Part 6
git add okx/[S-Z]*-1m*.feather
git commit -m "Okx spot 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

###################################################



###################################################


###################################################
# Binance Futures Part 1

git add binance/futures/*-1d*.feather
git commit -m "Binance Futures 1d Updated `date +%Y-%m-%d-%T`"

git add binance/futures/*-4h*.feather
git commit -m "Binance Futures 4h Updated `date +%Y-%m-%d-%T`"

git add binance/futures/*-1h*.feather
git commit -m "Binance Futures 1h Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

git add binance/futures/*-8h*.feather
git commit -m "Binance Futures Funding and Mark 8h Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Binance Futures Part 2
git add binance/futures/*-15m*.feather
git commit -m "Binance Futures 15m Updated `date +%Y-%m-%d-%T`"

git add binance/futures/*-5m*.feather
git commit -m "Binance Futures 5m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

git add binance/futures/*-3m*.feather
git commit -m "Binance Futures 3m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Binance Futures Part 3
git add binance/futures/[A-B]*-1m*.feather
git commit -m "Binance Futures 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

git add binance/futures/[C-D]*-1m*.feather
git commit -m "Binance Futures 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Binance Futures Part 4
git add binance/futures/[E-F]*-1m*.feather
git commit -m "Binance Futures 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Binance Futures Part 5
git add binance/futures/[G-M]*-1m*.feather
git commit -m "Binance Futures 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Binance Futures Part 5
git add binance/futures/[N-R]*-1m*.feather
git commit -m "Binance Futures 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Binance Futures Part 6
git add binance/futures/[S-Z]*-1m*.feather
git commit -m "Binance Futures 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

git add binance/futures/*.feather
git commit -m "Binance Futures Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# ###################################################
# # Kucoin Futures Part 1

# git add kucoinfutures/*-1d*.feather
# git commit -m "Kucoin Futures 1d Updated `date +%Y-%m-%d-%T`"

# git add kucoinfutures/*-4h*.feather
# git commit -m "Kucoin Futures 4h Updated `date +%Y-%m-%d-%T`"
# git push -u --force origin HEAD:main --verbose


# git add kucoinfutures/*-1h*.feather
# git commit -m "Kucoin Futures 1h Updated `date +%Y-%m-%d-%T`"
# git push -u --force origin HEAD:main --verbose

# # Kucoin Futures Part 2

# git add kucoinfutures/*-15m*.feather
# git commit -m "Kucoin Futures 15m Updated `date +%Y-%m-%d-%T`"
# git push -u --force origin HEAD:main --verbose

# git add kucoinfutures/[A-J]*-5m*.feather
# git commit -m "Kucoin Futures 5m Updated `date +%Y-%m-%d-%T`"
# git push -u --force origin HEAD:main --verbose

# git add kucoinfutures/[K-Z]*-5m*.feather
# git commit -m "Kucoin Futures 5m Updated `date +%Y-%m-%d-%T`"
# git push -u --force origin HEAD:main --verbose

# g
# # Kucoin Futures Part 3
# git add kucoinfutures/[A-B]*-3m*.feather
# git commit -m "Kucoin Futures 1m Updated `date +%Y-%m-%d-%T`"
# git push -u --force origin HEAD:main --verbose

# # Kucoin Futures Part 4
# git add kucoinfutures/[C-F]*-3m*.feather
# git commit -m "Kucoin Futures 1m Updated `date +%Y-%m-%d-%T`"
# git push -u --force origin HEAD:main --verbose

# # Kucoin Futures Part 5
# git add kucoinfutures/[G-M]*-3m*.feather
# git commit -m "Kucoin Futures 1m Updated `date +%Y-%m-%d-%T`"
# git push -u --force origin HEAD:main --verbose

# # Kucoin Futures Part 5
# git add kucoinfutures/[N-R]*-3m*.feather
# git commit -m "Kucoin Futures 1m Updated `date +%Y-%m-%d-%T`"
# git push -u --force origin HEAD:main --verbose

# # Kucoin Futures Part 6
# git add kucoinfutures/[S-Z]*-3m*.feather
# git commit -m "Kucoin Futures 1m Updated `date +%Y-%m-%d-%T`"
# git push -u --force origin HEAD:main --verbose


# # Kucoin Futures Part 7
# git add kucoinfutures/[A-B]*-1m*.feather
# git commit -m "Kucoin Futures 1m Updated `date +%Y-%m-%d-%T`"
# git push -u --force origin HEAD:main --verbose

# # Kucoin Futures Part 8
# git add kucoinfutures/[C-F]*-1m*.feather
# git commit -m "Kucoin Futures 1m Updated `date +%Y-%m-%d-%T`"
# git push -u --force origin HEAD:main --verbose

# # Kucoin Futures Part 9
# git add kucoinfutures/[G-M]*-1m*.feather
# git commit -m "Kucoin Futures 1m Updated `date +%Y-%m-%d-%T`"
# git push -u --force origin HEAD:main --verbose

# # Kucoin Futures Part 10
# git add kucoinfutures/[N-R]*-1m*.feather
# git commit -m "Kucoin Futures 1m Updated `date +%Y-%m-%d-%T`"
# git push -u --force origin HEAD:main --verbose

# # Kucoin Futures Part 11
# git add kucoinfutures/[S-Z]*-1m*.feather
# git commit -m "Kucoin Futures 1m Updated `date +%Y-%m-%d-%T`"
# git push -u --force origin HEAD:main --verbose


###################################################
# Okx Futures Part 1

git add okx/futures/*-1d*.feather
git commit -m "Okx Futures 1d Updated `date +%Y-%m-%d-%T`"

git add okx/futures/*-4h*.feather
git commit -m "Okx Futures 4h Updated `date +%Y-%m-%d-%T`"

git add okx/futures/*-1h*.feather
git commit -m "Okx Futures 1h Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Okx Futures Part 2

git add okx/futures/*-15m*.feather
git commit -m "Okx Futures 15m Updated `date +%Y-%m-%d-%T`"

git add okx/futures/*-5m*.feather
git commit -m "Okx Futures 5m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

git add okx/futures/*-3m*.feather
git commit -m "Okx Futures 3m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose


# Okx Futures Part 3
git add okx/futures/[A-B]*-1m*.feather
git commit -m "Okx Futures 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Okx Futures Part 4
git add okx/futures/[C-F]*-1m*.feather
git commit -m "Okx Futures 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Okx Futures Part 5
git add okx/futures/[G-M]*-1m*.feather
git commit -m "Okx Futures 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Okx Futures Part 5
git add okx/futures/[N-R]*-1m*.feather
git commit -m "Okx Futures 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

# Okx Futures Part 6
git add okx/futures/[S-Z]*-1m*.feather
git commit -m "Okx Futures 1m Updated `date +%Y-%m-%d-%T`"
git push -u --force origin HEAD:main --verbose

###################################################


# git add --all --verbose

# git status --porcelain --untracked-files=no | while read status file
# do
#    echo $status $file

#    if [ "$status" = "M" ]
#    then
#       git add $file
#       git commit -n $file -m "$file: $message"
#    elif [ "$status" = "A" ]
#    then
#       git add $file
#       git commit -n $file -m "added $file: $message"
#    elif [ "$status" = "D" ]
#    then
#       git rm $file
#       git commit -n $file -m "removed $file: $message"
#    else
#       echo "unknown status $file"
#    fi
# done


# # Adjust the following variables as necessary
# REMOTE=origin
# BRANCH=$(git rev-parse --abbrev-ref HEAD)
# BATCH_SIZE=200

# # check if the branch exists on the remote
# if git show-ref --quiet --verify refs/remotes/$REMOTE/$BRANCH; then
#     # if so, only push the commits that are not on the remote already
#     range=$REMOTE/$BRANCH..HEAD
# else
#     # else push all the commits
#     range=HEAD
# fi
# # count the number of commits to push
# n=$(git log --first-parent --format=format:x $range | wc -l)

# # push each batch
# for i in $(seq $n -$BATCH_SIZE 1); do
#     # get the hash of the commit to push
#     h=$(git log --first-parent --reverse --format=format:%H --skip $i -n1)
#     echo "Pushing $h..."
#     git push $REMOTE ${h}:refs/heads/$BRANCH --force
# done
# # push the final partial batch
# git push $REMOTE HEAD:refs/heads/$BRANCH --force

mv README-github.md README.md
git add README-github.md README.md
git commit -m "`date +%Y-%m-%d-%T` Repo Update Finished"
git push $REMOTE HEAD:refs/heads/$BRANCH --force

cd -
