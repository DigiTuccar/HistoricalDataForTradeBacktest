#!/bin/bash
# For data summary creation

# Update Futures data report for all exchanges and pairs

for exchange in `ls *-futures-usdt.json`;
        do docker run -v ".:/freqtrade/user_data/data" --rm freqtradeorg/freqtrade:stable \
        list-data --show-timerange -c user_data/data/$exchange \
        -c user_data/data/trading_mode-futures.json >summarized-reports/$exchange-data-report.md
        sed -i '/^+/d' summarized-reports/$exchange-data-report.md
        sed -i 's/+/|/g' summarized-reports/$exchange-data-report.md;
done


for exchange in `ls *-spot-usdt.json`;
        do docker run -v ".:/freqtrade/user_data/data" --rm freqtradeorg/freqtrade:stable \
        list-data --show-timerange -c user_data/data/$exchange \
        -c user_data/data/trading_mode-spot.json >summarized-reports/$exchange-data-report.md
        sed -i '/^+/d' summarized-reports/$exchange-data-report.md
        sed -i 's/+/|/g' summarized-reports/$exchange-data-report.md;
done
