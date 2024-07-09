#!/bin/bash
# This script downloads necessary data from DigiTuccar Historical Data For Backtesting
# The repo is huge and this script download only necessary info
# The repo HistoricalDataForTradeBacktest from DigiTuccar is regularly and automatically updating
# You can run this script regularly to update your data for new backteswting periods
MAIN_DATA_DIRECTORY="user_data/data"
# For manual running you can use these
TIMEFRAME="5m"
HELPER_TIME_FRAMES="1d 4h 1h 15m 1m"
# EXAMPLE
# TRADING_MODE="spot futures"
TRADING_MODE="spot"
# EXAMPLE
# EXCHANGE="binance kucoin okx"
EXCHANGE="binance gateio okx kucoin"

TEMP_GITHUB_REPO_DIRECTORY=GH-TEMP-HistoricalDataForTradeBacktest-NO-LFS
rm -rf $TEMP_GITHUB_REPO_DIRECTORY
rclone copy /opt/digituccar/historical-data-for-back-tests/ $TEMP_GITHUB_REPO_DIRECTORY --multi-thread-streams=32 --exclude "/.git/**"
sudo chown idareci:idareci $TEMP_GITHUB_REPO_DIRECTORY -R
cd $TEMP_GITHUB_REPO_DIRECTORY
git config --global --add safe.directory $(pwd)
rm .gitattributes
rm .git-config-template

echo "*.feather binary" >.gitattributes
git init
git branch -m main
echo "git init edildi"
git remote add origin https://github.com/DigiTuccar/HistoricalDataForTradeBacktest.git
#git remote add origin git@github.com:DigiTuccar/TEMP-HistoricalDataForTradeBacktest.git
echo "git remote add origin https://github.com/DigiTuccar/HistoricalDataForTradeBacktest.git yapildi"
git config --local user.name "DigiTuccar Auto Updater"
git config --local user.email "auto-updater-system@digituccar.com"
git config credential.helper store
git config --local http.postBuffer 2147483648
git config --local ssh.postBuffer 2147483648

# AYAR EKLENDİ
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
git commit -am "Repo Current Version $(date +%Y-%m-%d-%T)" --verbose
git push -u --force origin HEAD:main --verbose


###############################################################################
# Binance Spot
###############################################################################

git add binance/*-1d*.feather
git commit -m "Binance spot 1d"
git push --verbose

git add binance/*-4h*.feather
git commit -m "Binance spot 4h"
git push --verbose

git add binance/*-1h*.feather
git commit -m "Binance spot 1h"
git push --verbose

git add binance/*-15m*.feather
git commit -m "Binance spot 15m"
git push --verbose

git add binance/[A-J]*-5m*.feather
git commit -m "Binance spot 5m"
git push --verbose

git add binance/[K-Z]*-5m*.feather
git commit -m "Binance spot 5m"
git push --verbose


for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add binance/${PAIR_FILE}*-3m*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done


for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add binance/${PAIR_FILE}*-1m*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

git add binance/*.feather
git commit -m "Binance spot"
git push --verbose

###############################################################################
# Kucoin Spot
###############################################################################
git add kucoin/*-1d*.feather
git commit -m "Kucoin spot 1d"

git add kucoin/*-4h*.feather
git commit -m "Kucoin spot 4h"
git push --verbose

git add kucoin/*-1h*.feather
git commit -m "Kucoin spot 1h"
git push --verbose

git add kucoin/*-15m*.feather
git commit -m "Kucoin spot 15m"
git push --verbose

# Kucoin 5m

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add kucoin/${PAIR_FILE}*-5m*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

# Kucoin 3m

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add kucoin/${PAIR_FILE}*-3m*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add kucoin/${PAIR_FILE}*-1m*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

git add kucoin/*.feather
git commit -m "Kucoin spot"
git push --verbose


###############################################################################
# Binance Futures
###############################################################################


for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add binance/futures/${PAIR_FILE}*-1d*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 1d pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add binance/futures/${PAIR_FILE}*-8h*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 8h pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add binance/futures/${PAIR_FILE}*-4h*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 4h pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add binance/futures/${PAIR_FILE}*-1h*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 1h pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add binance/futures/${PAIR_FILE}*-15m*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 15m pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add binance/futures/${PAIR_FILE}*-5m*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 5m pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add binance/futures/${PAIR_FILE}*-3m*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 3m pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add binance/futures/${PAIR_FILE}*-1m*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 1m pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

# for firstletter in {A..Z}; do
# for PAIR_FILE in {A..Z}; do
#   #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
#   git add binance/futures/$firstletter${PAIR_FILE}*-1m*.feather
#   git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 1m pairs name starting with $firstletter$PAIR_FILE"
#   git push -u --force origin HEAD:main --verbose
# done
# done

git add binance/futures/*.feather
git commit -m "Binance futures"
git push --verbose

###############################################################################
# Gateio Spot
###############################################################################

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add gateio/${PAIR_FILE}*-1d*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 1d pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add gateio/${PAIR_FILE}*-4h*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 4h pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done



for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add gateio/${PAIR_FILE}*-1h*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 1h pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done


for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add gateio/${PAIR_FILE}*-15m*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 15m pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done


for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add gateio/${PAIR_FILE}*-5m*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 5m pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

for firstletter in {A..Z}; do
for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add gateio/$firstletter${PAIR_FILE}*-1m*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 1m pairs name starting with $firstletter$PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done
done

git add gateio/*.feather
git commit -m "Gateio spot"
git push --verbose




###############################################################################
# Gateio Futures
###############################################################################


for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add gateio/futures/${PAIR_FILE}*-1d*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 1d pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add gateio/futures/${PAIR_FILE}*-8h*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 8h pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done


for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add gateio/futures/${PAIR_FILE}*-4h*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 4h pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add gateio/futures/${PAIR_FILE}*-1h*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 1h pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done


for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add gateio/futures/${PAIR_FILE}*-15m*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 15m pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done


for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add gateio/futures/${PAIR_FILE}*-5m*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 5m pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add gateio/futures/${PAIR_FILE}*-1m*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 1m pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

# for firstletter in {A..Z}; do
# for PAIR_FILE in {A..Z}; do
#   #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
#   git add gateio/futures/$firstletter${PAIR_FILE}*-1m*.feather
#   git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 1m pairs name starting with $firstletter$PAIR_FILE"
#   git push -u --force origin HEAD:main --verbose
# done
# done

git add gateio/futures/*.feather
git commit -m "Gateio futures"
git push --verbose


###############################################################################
# Okx Futures
###############################################################################

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add okx/futures/${PAIR_FILE}*-1d*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 1d pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add okx/futures/${PAIR_FILE}*-8h*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 8h pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add okx/futures/${PAIR_FILE}*-4h*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 4h pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add okx/futures/${PAIR_FILE}*-1h*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 1h pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add okx/futures/${PAIR_FILE}*-15m*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 15m pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add okx/futures/${PAIR_FILE}*-5m*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 5m pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add okx/futures/${PAIR_FILE}*-3m*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 3m pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

for PAIR_FILE in {A..Z}; do
  #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
  git add okx/futures/${PAIR_FILE}*-1m*.feather
  git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 1m pairs name starting with $PAIR_FILE"
  git push -u --force origin HEAD:main --verbose
done

# for firstletter in {A..Z}; do
# for PAIR_FILE in {A..Z}; do
#   #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
#   git add okx/futures/$firstletter${PAIR_FILE}*-1m*.feather
#   git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe 1m pairs name starting with $firstletter$PAIR_FILE"
#   git push -u --force origin HEAD:main --verbose
# done
# done

git add okx/futures/*.feather
git commit -m "Okx futures"
git push --verbose


# ###############################################################################
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


###############################################################################
# Finish Update
###############################################################################
mv README-github.md README.md
git add README-github.md README.md
git commit -m "$(date +%Y-%m-%d-%T) Repo Update Finished"
git push $REMOTE HEAD:refs/heads/$BRANCH --force

cd -


