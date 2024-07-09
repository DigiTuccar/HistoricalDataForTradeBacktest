#!/bin/bash

TEMP_GITHUB_REPO_DIRECTORY=GH-TEMP-HistoricalDataForTradeBacktest-NO-LFS
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
git remote add origin https://github.com/DigiTuccar/TEMP-HistoricalDataForTradeBacktest.git
#git remote add origin git@github.com:DigiTuccar/TEMP-HistoricalDataForTradeBacktest.git
echo "git remote add origin https://github.com/DigiTuccar/TEMP-HistoricalDataForTradeBacktest.git yapildi"
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
git commit -m "Binance spot 1d"

git add binance/*-4h*.feather
git commit -m "Binance spot 4h"

git add binance/*-1h*.feather
git commit -m "Binance spot 1h"
git push --verbose

# Binance Part 2

git add binance/*-15m*.feather
git commit -m "Binance spot 15m"

git add binance/[A-J]*-5m*.feather
git commit -m "Binance spot 5m"
git push --verbose

git add binance/[K-Z]*-5m*.feather
git commit -m "Binance spot 5m"
git push --verbose


git add binance/[A-J]*-3m*.feather
git commit -m "Binance spot 3m"
git push --verbose

git add binance/[K-Z]*-3m*.feather
git commit -m "Binance spot 3m"
git push --verbose


  for PAIR_FILE in {A..Z}; do
      #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
      git add binance/${PAIR_FILE}*-1m*.feather
      git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe pairs name starting with $PAIR_FILE"
      git push -u --force origin HEAD:main --verbose
  done


git add binance/*.feather
git commit -m "Binance spot"
git push --verbose

###################################################
# Kucoin Part 1

git add kucoin/*-1d*.feather
git commit -m "Kucoin spot 1d"

git add kucoin/*-4h*.feather
git commit -m "Kucoin spot 4h"
git push --verbose


git add kucoin/*-1h*.feather
git commit -m "Kucoin spot 1h"
git push --verbose

# Kucoin Part 2

git add kucoin/*-15m*.feather
git commit -m "Kucoin spot 15m"
git push --verbose

git add kucoin/[A-J]*-5m*.feather
git commit -m "Kucoin spot 5m"
git push --verbose


git add kucoin/[K-Z]*-5m*.feather
git commit -m "Kucoin spot 5m"
git push --verbose

# Kucoin Part 3
git add kucoin/[A-B]*-3m*.feather
git commit -m "Kucoin spot 3m"
git push --verbose

# Kucoin Part 4
git add kucoin/[C-F]*-3m*.feather
git commit -m "Kucoin spot 3m"
git push --verbose

# Kucoin Part 5
git add kucoin/[G-M]*-3m*.feather
git commit -m "Kucoin spot 3m"
git push --verbose

# Kucoin Part 5
git add kucoin/[N-R]*-3m*.feather
git commit -m "Kucoin spot 3m"
git push --verbose

# Kucoin Part 6
git add kucoin/[S-Z]*-3m*.feather
git commit -m "Kucoin spot 3m"
git push --verbose


  for PAIR_FILE in {A..Z}; do
      #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
      git add kucoin/${PAIR_FILE}*-1m*.feather
      git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe pairs name starting with $PAIR_FILE"
      git push -u --force origin HEAD:main --verbose
  done


git add kucoin/*.feather
git commit -m "Kucoin spot"
git push --verbose

###################################################
# Okx Part 1

git add okx/*-1d*.feather
git commit -m "Okx spot 1d"

git add okx/*-4h*.feather
git commit -m "Okx spot 4h"

git add okx/*-1h*.feather
git commit -m "Okx spot 1h"
git push --verbose

# Okx Part 2

git add okx/*-15m*.feather
git commit -m "Okx spot 15m"

git add okx/*-5m*.feather
git commit -m "Okx spot 5m"
git push --verbose

git add okx/*-3m*.feather
git commit -m "Okx spot 3m"
git push --verbose


  for PAIR_FILE in {A..Z}; do
      #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
      git add okx/${PAIR_FILE}*-1m*.feather
      git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe pairs name starting with $PAIR_FILE"
      git push -u --force origin HEAD:main --verbose
  done


git add okx/*.feather
git commit -m "Binance spot"
git push --verbose

###################################################



###################################################


###################################################
# Binance Futures Part 1

git add binance/futures/*-1d*.feather
git commit -m "Binance Futures 1d"

git add binance/futures/*-4h*.feather
git commit -m "Binance Futures 4h"

git add binance/futures/*-1h*.feather
git commit -m "Binance Futures 1h"
git push --verbose

git add binance/futures/*-8h*.feather
git commit -m "Binance Futures Funding and Mark 8h"
git push --verbose

# Binance Futures Part 2
git add binance/futures/*-15m*.feather
git commit -m "Binance Futures 15m"

git add binance/futures/*-5m*.feather
git commit -m "Binance Futures 5m"
git push --verbose

git add binance/futures/*-3m*.feather
git commit -m "Binance Futures 3m"
git push --verbose


  for PAIR_FILE in {A..Z}; do
      #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
      git add binance/futures/${PAIR_FILE}*-1m*.feather
      git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe pairs name starting with $PAIR_FILE"
      git push -u --force origin HEAD:main --verbose
  done


git add binance/futures/*.feather
git commit -m "Binance Futures"
git push --verbose

# ###################################################
# # Kucoin Futures Part 1

# git add kucoinfutures/*-1d*.feather
# git commit -m "Kucoin Futures 1d"

# git add kucoinfutures/*-4h*.feather
# git commit -m "Kucoin Futures 4h"
# git push --verbose


# git add kucoinfutures/*-1h*.feather
# git commit -m "Kucoin Futures 1h"
# git push --verbose

# # Kucoin Futures Part 2

# git add kucoinfutures/*-15m*.feather
# git commit -m "Kucoin Futures 15m"
# git push --verbose

# git add kucoinfutures/[A-J]*-5m*.feather
# git commit -m "Kucoin Futures 5m"
# git push --verbose

# git add kucoinfutures/[K-Z]*-5m*.feather
# git commit -m "Kucoin Futures 5m"
# git push --verbose

# # Kucoin Futures Part 3
# git add kucoinfutures/[A-B]*-3m*.feather
# git commit -m "Kucoin Futures 1m"
# git push --verbose

# # Kucoin Futures Part 4
# git add kucoinfutures/[C-F]*-3m*.feather
# git commit -m "Kucoin Futures 1m"
# git push --verbose

# # Kucoin Futures Part 5
# git add kucoinfutures/[G-M]*-3m*.feather
# git commit -m "Kucoin Futures 1m"
# git push --verbose

# # Kucoin Futures Part 5
# git add kucoinfutures/[N-R]*-3m*.feather
# git commit -m "Kucoin Futures 1m"
# git push --verbose

# # Kucoin Futures Part 6
# git add kucoinfutures/[S-Z]*-3m*.feather
# git commit -m "Kucoin Futures 1m"
# git push --verbose


# # Kucoin Futures Part 7
# git add kucoinfutures/[A-B]*-1m*.feather
# git commit -m "Kucoin Futures 1m"
# git push --verbose

# # Kucoin Futures Part 8
# git add kucoinfutures/[C-F]*-1m*.feather
# git commit -m "Kucoin Futures 1m"
# git push --verbose

# # Kucoin Futures Part 9
# git add kucoinfutures/[G-M]*-1m*.feather
# git commit -m "Kucoin Futures 1m"
# git push --verbose

# # Kucoin Futures Part 10
# git add kucoinfutures/[N-R]*-1m*.feather
# git commit -m "Kucoin Futures 1m"
# git push --verbose

# # Kucoin Futures Part 11
# git add kucoinfutures/[S-Z]*-1m*.feather
# git commit -m "Kucoin Futures 1m"
# git push --verbose


###################################################
# Okx Futures Part 1

git add okx/futures/*-1d*.feather
git commit -m "Okx Futures 1d"

git add okx/futures/*-4h*.feather
git commit -m "Okx Futures 4h"

git add okx/futures/*-1h*.feather
git commit -m "Okx Futures 1h"
git push --verbose

# Okx Futures Part 2

git add okx/futures/*-15m*.feather
git commit -m "Okx Futures 15m"

git add okx/futures/*-5m*.feather
git commit -m "Okx Futures 5m"
git push --verbose

git add okx/futures/*-3m*.feather
git commit -m "Okx Futures 3m"
git push --verbose


# Okx Futures Part 3
git add okx/futures/[A-B]*-1m*.feather
git commit -m "Okx Futures 1m"
git push --verbose

# Okx Futures Part 4
git add okx/futures/[C-F]*-1m*.feather
git commit -m "Okx Futures 1m"
git push --verbose

# Okx Futures Part 5
git add okx/futures/[G-M]*-1m*.feather
git commit -m "Okx Futures 1m"
git push --verbose

# Okx Futures Part 5
git add okx/futures/[N-R]*-1m*.feather
git commit -m "Okx Futures 1m"
git push --verbose

# Okx Futures Part 6
git add okx/futures/[S-Z]*-1m*.feather
git commit -m "Okx Futures 1m"
git push --verbose

###################################################

mv README-github.md README.md
git add README-github.md README.md
git commit -m "`date +%Y-%m-%d-%T` Repo Update Finished"
git push $REMOTE HEAD:refs/heads/$BRANCH --force

cd -

