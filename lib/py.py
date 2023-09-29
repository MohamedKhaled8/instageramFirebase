# دالة لحساب الربح من الرهان بناءً على الأرقام الكسرية
def calculate_profit(stake, odds):
    numerator, denominator = odds.split('/')
    numerator = int(numerator)
    denominator = int(denominator)

    if denominator == 0:
        return "المخاطرة غير صحيحة"

    profit = (numerator / denominator) * stake
    return profit

# استخدام الدالة
stake = float(input("أدخل المخاطرة: "))
odds = input("أدخل الأرقام الكسرية (مثل 5/1): ")

profit = calculate_profit(stake, odds)
if isinstance(profit, str):
    print(profit)
else:
    print(f"الربح المحتمل: {profit}")
