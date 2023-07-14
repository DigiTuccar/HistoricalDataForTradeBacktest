[![pipeline status](https://code.denomas.com/digittuccar/historical-data-for-back-tests/badges/develop/pipeline.svg)](https://code.denomas.com/digittuccar/historical-data-for-back-tests/-/commits/develop)

# Historical Exchange Data For BackTests

Historical Data for backtesting
This repo automatically updates itself
## Data Format
feather for better speed
please check the comparison for data write and read speed tests

## Updating Data

Edit these files to update the dates, commit and push to the repo.
``backtesting-binance-spot.env``
``backtesting-binance-futures.env``
``backtesting-kucoin-spot.env`
``backtesting-kucoin-futures.env`
``backtesting-okx-spot.env`
``backtesting-okx-futures.env`

An automated Github Action will download the data and commit it to the repository.


# Adding Exchanges and first download

Run this command for first time added exchanges:
```sh
docker-compose --env-file backtesting-binance-futures.env -f docker-compose-first-time-download.yml run --rm download-data
````


Run this command for update selected exchanges:
```sh
docker-compose --env-file backtesting-binance-futures.env run --rm download-data
````


# Helpful resources
https://shuhrat.github.io/programming/git-lfs-tips-and-tricks.html

For git-lfs necessary commands:
```sh
git config --global filter.lfs.required true
git config --global filter.lfs.clean "git-lfs clean -- %f"
git config --global filter.lfs.smudge "git-lfs smudge -- %f"
git config --global filter.lfs.process "git-lfs filter-process"
```


# Verileri Temizlemek İçin
```sh
git checkout --orphan latest_branch
git add .
git commit -m "data updated"
git branch -D main
git branch -m main
git push -f origin main
git status
du -sh .
git gc --prune=now --aggressive
du -sh .
git reflog expire --all --expire=now
git gc --aggressive
git prune
````

# Veri Aralıklarının Sağlığını Kontrol Etmek için

```sh
for i in `docker run -v ".:/freqtrade/user_data" --rm freqtradeorg/freqtrade:stable list-pairs -c config.json -1`;do docker run -v "./user_data:/freqtrade/user_data" --rm freqtradeorg/freqtrade:stable list-data -c user_data/config.json  --show-timerange --pairs $i ; done



#other
for i in `docker run -v ".:/freqtrade/user_data/data" --rm freqtradeorg/freqtrade:stable list-pairs -c user_data/data/binance-usdt-futures.json -c user_data/data/pairlists-futures.json -1`;do docker run -v ".:/freqtrade/user_data/data" --rm freqtradeorg/freqtrade:stable list-data -c user_data/data/binance-usdt-futures.json -c user_data/data/pairlists-futures.json  --show-timerange --pairs $i ; done

````



ls *backtesting*futures.env

ls *backtesting*spot.env


# Futures Config
```json
{
  "trading_mode": "futures",
  "margin_mode": "isolated",
  "dataformat_ohlcv": "feather",
  "dataformat_trades": "feather",
  "exchange": {
    "ccxt_config": {
      "options": {
        "defaultType": "future"
      }
    },
    "ccxt_async_config": {
      "options": {
        "defaultType": "future"
      }
    }
  }
}
```

# Futures Proxy Config
```json
{
  "trading_mode": "futures",
  "margin_mode": "isolated",
  "dataformat_ohlcv": "feather",
  "dataformat_trades": "feather",
  "exchange": {
    "ccxt_config": {
      "options": {
        "defaultType": "future"
      },
      "aiohttp_proxy": "http://173.212.222.126:3128/",
      "proxies": {
        "http": "http://173.212.222.126:3128/",
        "https": "http://173.212.222.126:3128/"
      },
      "enableRateLimit": true,
      "timeout": 60000
    },
    "ccxt_async_config": {
      "options": {
        "defaultType": "future"
      },
      "enableRateLimit": true,
      "timeout": 60000
    }
  }
}
```
# Pairlist Config
## pairlists-spot.json
```json
{
  "trading_mode": "spot",
  "dataformat_ohlcv": "feather",
  "dataformat_trades": "feather"
}
```

## Proxy Spot Config

```json
{
  "trading_mode": "spot",
  "dataformat_ohlcv": "feather",
  "dataformat_trades": "feather"
  "exchange": {
    "ccxt_config": {
      "aiohttp_proxy": "http://173.212.222.126:3128/",
      "proxies": {
        "http": "http://173.212.222.126:3128/",
        "https": "http://173.212.222.126:3128/"
      },
      "enableRateLimit": true,
      "timeout": 60000
    },
    "ccxt_async_config": {
      "enableRateLimit": true,
      "timeout": 60000
    }
  }
}
```

# Summarized Reports
see summarized-reports folder


# For data summary creation
## Update Futures data report for all exchanges and pairs
```sh
for exchange in `ls *-usdt-futures.json`;do docker run -v ".:/freqtrade/user_data/data" --rm freqtradeorg/freqtrade:stable list-data --show-timerange -c user_data/data/$exchange -c user_data/data/pairlists-futures.json >summarized-reports/$exchange-data-report.md;done
```

## Update Spot data report for all exchanges and pairs

```sh
for exchange in `ls *-usdt-spot.json`;do docker run -v ".:/freqtrade/user_data/data" --rm freqtradeorg/freqtrade:stable list-data --show-timerange -c user_data/data/$exchange -c user_data/data/pairlists-spot.json >summarized-reports/$exchange-data-report.md;done
```
