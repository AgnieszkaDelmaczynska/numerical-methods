import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
plt.style.use('dark_background')


# wykładnicza średnia krocząca
def ema(data: [float], N: int):
    new_list = []
    for current_sample in range(len(data)):
        alpha = 2/(N+1)
        base = 1 - alpha
        licznik = float(0.0)
        mianownik = float(0.0)
        for i in range(N+1):
            if current_sample - i >= 0:
                licznik += pow(base, i) * data[current_sample-i]
                mianownik += pow(base, i)
        new_list.append(licznik/mianownik)
    return new_list


def macd(data: [float]):
    macd_list = []
    EMA12_list = ema(data, 12)
    EMA26_list = ema(data, 26)
    for i in range(len(data)):
        macd_list.append(EMA12_list[i] - EMA26_list[i])
    return macd_list


def signal(MACD):
    return ema(MACD, 9)


def histogram(data: [float]):
    histogram_list = []
    temp_MACD_signal_line = ema(MACD, 9)
    for i in range(len(data)):
        histogram_list.append(temp_MACD_signal_line[i] - MACD[i])
    return histogram_list


if __name__ == '__main__':

    plik = pd.read_csv('LPP.WA.csv', usecols=['Date', 'Close', 'Open'])
    plik.columns = [f"{column}" for column in plik.columns]
    Date = list(plik.loc[:, "Date"])
    Close = list(plik.loc[:, "Close"])
    Open = list(plik.loc[:, "Open"])
    print(plik)

    plt.figure(1, figsize=(12, 4))
    plt.axes()
    plt.grid(True)
    plt.plot(Date, Close)
    plt.legend(['Legend'])
    plt.xticks(np.arange(0, len(Date), len(Date)/7))
    plt.xlabel('Daty (yyyy-mm-dd)')
    plt.ylabel('Ceny akcji')
    plt.title("Wykres cen akcji firmy LPP od daty")
    plt.show()

    MACD = macd(Close)
    SIGNAL = signal(MACD)
    HISTOGRAM = histogram(MACD)

    plik['MACD'] = MACD
    plik['SIGNAL'] = SIGNAL
    plik['Histogram'] = HISTOGRAM
    print(plik)

    plt.figure(2, figsize=(12, 4))
    plt.axes()
    plt.grid(True)
    plt.plot(Date, MACD, label="MACD", color='blue')
    plt.legend()
    plt.plot(Date, SIGNAL, label='SIGNAL', color='red')
    plt.legend()
    plt.xticks(np.arange(0, len(Date), len(Date)/7))
    plt.xlabel('Data (yyyy-mm-dd)')
    plt.ylabel('Wartość składowych')
    plt.title('Wskaźnik MACD')
    plt.show()

    # przechowuje sygnały
    buy, sell = [], []
    for i in range(34, len(Close)):
        # przecinanie od dołu i czy było tak poprzedniego dnia
        if MACD[i] > SIGNAL[i] and MACD[i-1] < SIGNAL[i-1]:
            # i - numer wiersza, w którym spełniony jest warunek kupna
            buy.append(i)
        # przecinanie od góry i czy było tak poprzedniego dnia
        elif MACD[i] < SIGNAL[i] and MACD[i-1] > SIGNAL[i-1]:
            # i - numer wiersza, w którym spełniony jest warunek sprzedaży
            sell.append(i)

    # daty, kiedy należy kupić akcje i ich ceny
    # musimy dostać się do tego samego numeru rzędu, jaki został umieszczony
    # w liście "buy[]" jako potencjalny moment kupna
    date_to_buy, price_at_close_to_buy = [], []
    for i in buy:
        date_to_buy.append(Date[i])
        price_at_close_to_buy.append(Close[i])

    # daty, kiedy należy sprzedać akcje i ich ceny
    # musimy dostać się do tego samego numeru rzędu, jaki został umieszczony
    # w liście "sell[]" jako potencjalny moment sprzedaży
    date_to_sell, price_at_close_to_sell = [], []
    for i in sell:
        date_to_sell.append(Date[i])
        price_at_close_to_sell.append(Close[i])

    plt.figure(3, figsize=(12, 4))
    plt.grid(True)
    plt.plot(Date, Close, label='wykres z miejscami buy/sell')
    plt.legend()
    plt.xticks(np.arange(0, len(Date), len(Date)/7))
    plt.xlabel('Data (yyyy-mm-dd)')
    plt.ylabel('Wartość składowych')
    plt.title('Wykres z sugerowanymi miejscami kupna i sprzedaży')
    plt.scatter(date_to_buy, price_at_close_to_buy, marker="^", color='green')
    plt.scatter(date_to_sell, price_at_close_to_sell, marker="v", color='red')
    plt.show()


    current_wallet, starting_wallet = 1000, 1000
    # nie możemy przekalkulować zysku, gdy pierwszym sygnałem jest sygnał sprzedaży
    # ponieważ nie wiemy z jakim sygnałem buy go porównać
    # w takim przypadku powinniśmy nie brać tej pierwszej wartości pod uwagę
    if sell[0] < buy[0]:
        sell.pop(0)
    # ostatni odebrany sygnał przecięcia się MACD i SIGNAL to sygnał zakupu
    # nie możemy jednak brać tego za dobry wynik, ponieważ nie wiemy
    # jaki byłby sygnał sprzedaży, musimy również wykluczyć ten przypadek
    elif buy[-1] > sell[-1]:
        buy.pop(-1)

    for i in buy:
        # kupujemy, czyli wydajemy pieniądze, stąd "-="
        current_wallet -= Close[i]
    for i in sell:
        # sprzedajemy, czyli dostajemy pieniądze, stąd "+="
        current_wallet += Close[i]

    txt1 = "starting wallet: {}"
    print(txt1.format(starting_wallet))
    txt2 = "current wallet: {}"
    print(txt2.format(round(current_wallet, 2)))
    txt3 = "profit: {}"
    print(txt3.format(round(current_wallet - starting_wallet, 2)))
    # -86.95, tyle na minusie z zysku

    # sprawdźmy, jaka rzeczywiście jest wtedy skuteczność MACD
    effectiveness = 0.0
    for i in range(0, len(buy)):
        if Close[buy[i]] < Close[sell[i]]:
            effectiveness += 1
    result = round(effectiveness/len(buy)*100, 2)
    summary = "effectiveness: {}%"
    print(summary.format(result))

    if result > 50.0:
        print("MACD is effective!")
    else:
        print("MACD is not really effective :(")
    # 38.64%, taki procent par daje dobry wynik
    print(plik)
