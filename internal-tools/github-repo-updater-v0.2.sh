#!/bin/bash


###################################################
# Prepare Repo Directory
###################################################

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

###################################################
# Prepare Repo Config
###################################################

git remote add origin https://github.com/DigiTuccar/TEMP-HistoricalDataForTradeBacktest.git
#git remote add origin git@github.com:DigiTuccar/TEMP-HistoricalDataForTradeBacktest.git
echo "git remote add origin https://github.com/DigiTuccar/TEMP-HistoricalDataForTradeBacktest.git yapildi"
git config --local user.name "DigiTuccar Auto Updater"
git config --local user.email "auto-updater-system@digituccar.com"
git config credential.helper store
git config --local http.postBuffer 2147483648
git config --local ssh.postBuffer 2147483648
git config core.bigFileThreshold 1m
git config core.compression 0
git config core.looseCompression 0
git config core.deltaBaseCacheLimit 2g
killall -9 watchman
watchman watch .
cp .git/hooks/fsmonitor-watchman.sample .git/hooks/query-watchman
git config core.fsmonitor .git/hooks/query-watchman
git config core.packedGitWindowSize 2g
git config core.untrackedcache true
git config fastimport.unpackLimit 0
git config feature.manyFiles true
git config fsmonitor.allowRemote true
git config gc.bigPackThreshold 0
git config pack.compression 0
git config pack.packSizeLimit 2g

###################################################
# İlk dosyaları ekle
###################################################
mv README-Github-Repo-Updating-now.md README.md
git add *.json *.env .gitattributes .gitignore LICENSE .github .pre-commit-config.yaml internal-tools summarized-reports *.* --verbose
echo "git add *.json *.env README.md --verbose tamam"
git commit -am "Repo Current Version `date +%Y-%m-%d-%T`" --verbose
git push -u --force origin HEAD:main --verbose




###################################################
# Exchange Dosyalarını Ekle
###################################################



###############################################################################
###############################################################################
###############################################################################

# For manual running you can use these
# TIMEFRAME="5m"
TIME_FRAME="1d 8h 4h 1h 15m 5m"
# TIME_FRAME="1d 4h 8h"
# EXAMPLE
# TRADING_MODE="spot futures"
TRADING_MODE="spot futures"
# EXAMPLE
# EXCHANGE="binance kucoin okx"
EXCHANGE="binance gateio okx kucoin kucoinfutures"

echo "Pushing Necessary Helper Timeframe Data"

for data_necessary_exchange in ${EXCHANGE[*]}
    do
        for data_necessary_market_type in ${TRADING_MODE[*]}
            do
                for data_necessary_timeframe in ${TIME_FRAME[*]}
                    do
                        echo
                        echo "--------------------------------------------------------------------------------------------------------"
                        echo "# Exchange: $data_necessary_exchange      Market Type: $data_necessary_market_type      Time Frame: $data_necessary_timeframe"
                        echo "--------------------------------------------------------------------------------------------------------"
                        echo

                        EXCHANGE_MARKET_DIRECTORY=$data_necessary_exchange

                        if [[ $data_necessary_market_type == futures ]]
                            then
                                EXCHANGE_MARKET_DIRECTORY=$data_necessary_exchange/futures
                            else
                                EXCHANGE_MARKET_DIRECTORY=$data_necessary_exchange
                        fi

                        # SİHİR BURADA BAŞLIYOR

                        for PAIR_FILE in {A..Z}; do
                            #echo $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
                            git add $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
                            git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe pairs name starting with $PAIR_FILE"
                            git push -u --force origin HEAD:main --verbose

                                                        
                        done

                        # SİHİRİN İKİNCİ DÖNGÜSÜ
                        for PAIR_FILE in {0..9}; do
                            git add $EXCHANGE_MARKET_DIRECTORY/${PAIR_FILE}*-$data_necessary_timeframe*.feather
                            git commit -m "$data_necessary_exchange $data_necessary_market_type $data_necessary_timeframe pairs name starting with $PAIR_FILE"
                            git push -u --force origin HEAD:main --verbose
                        done

                        # SİHİR BURADA BİTMİŞ OLDU


                    done
            done
    done


echo "---------------------------------------------"
echo "All necessary data pushed"




for i in `ls gateio/*-1m*.feather`; do git add $i; git commit -m "$i added" ; git push -u --force origin HEAD:main --verbose ;done
###################################################
# Binance Part 1

# git add binance/*-1d*.feather
# git commit -m "Binance spot 1d Updated `date +%Y-%m-%d-%T`"

# git add binance/*-4h*.feather
# git commit -m "Binance spot 4h Updated `date +%Y-%m-%d-%T`"

# git add binance/*-1h*.feather
# git commit -m "Binance spot 1h Updated `date +%Y-%m-%d-%T`"
# git push -u --force origin HEAD:main --verbose




###################################################

mv README-github.md README.md
git add README-github.md README.md
git commit -m "`date +%Y-%m-%d-%T` Repo Update Finished"
git push $REMOTE HEAD:refs/heads/$BRANCH --force

cd -

