# Historical Exchange Data For BackTests

# This repo is HUGE (70GB)

Please use this script download only necessary info
tools/download-necessary-exchange-market-data-for-backtests.sh

# The repo HistoricalDataForTradeBacktest from DigiTuccar is regularly and automatically updating

# You can run this script regularly to update your data for new backteswting periods

```bash
./tools/download-necessary-exchange-market-data-for-backtests.sh
```

Historical Data for backtesting
This repo automatically updates itself

## Data Format

feather for better speed

# Summarized Reports

see summarized-reports folder

## Updating Data

Edit these files to update the dates, commit and push to the repo.
``download-data-binance-spot.env``
``download-data-binance-futures.env``
``download-data-kucoin-spot.env`
``download-data-okx-spot.env`
``download-data-okx-futures.env`

An automated Github Action will download the data and commit it to the repository.

# Adding Exchanges and first download

Run this command for first time added exchanges:

```sh
docker-compose --env-file download-data-binance-futures.env -f docker-compose-first-time-download.yml run --rm download-data
````

Run this command for update selected exchanges:

```sh
docker-compose --env-file download-data-binance-futures.env run --rm download-data
```

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
      "aiohttp_proxy": "http://123.123.123.123:3128/",
      "proxies": {
        "http": "http://123.123.123.123:3128/",
        "https": "http://123.123.123.123:3128/"
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
      "aiohttp_proxy": "http://123.123.123.123:3128/",
      "proxies": {
        "http": "http://123.123.123.123:3128/",
        "https": "http://123.123.123.123:3128/"
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

# For data summary creation

## Update Futures data report for all exchanges and pairs

```sh
for exchange in `ls *-usdt-futures.json`;do docker run -v ".:/freqtrade/user_data/data" --rm freqtradeorg/freqtrade:stable list-data --show-timerange -c user_data/data/$exchange -c user_data/data/pairlists-futures.json >summarized-reports/$exchange-data-report.md;done
```

## Update Spot data report for all exchanges and pairs

```sh
for exchange in `ls *-usdt-spot.json`;do docker run -v ".:/freqtrade/user_data/data" --rm freqtradeorg/freqtrade:stable list-data --show-timerange -c user_data/data/$exchange -c user_data/data/pairlists-spot.json >summarized-reports/$exchange-data-report.md;done
```
