Menu = {
    '1': {'Name': 'Biryani', 'Category': 'Main_course', 'price': 130, 'count': 50},
    '2': {'Name': 'Pizza', 'Category': '\t Snacks   ', 'price': 150, 'count': 30},
    '3': {'Name': 'Pasta', 'Category': '\t Snacks   ', 'price': 125, 'count': 25},
    '4': {'Name': 'Cheese_cake', 'Category': 'Dessert', 'price': 70, 'count': 45},
}

user = {}
total_order = 0


def menu():
    print("----Menu----")
    print("No\tItem\t\tCategory\tPrice")
    for no, item in Menu.items():
        print(no, "\t", item['Name'], "\t", item['Category'], "\t", item['price'])


def delivery_charge(subtotal):
    if subtotal > 500:
        return 0
    elif subtotal > 200:
        return 30
    else:
        return 50


def Coupon(subtotal, coupon):
    coupon = coupon.upper()

    if coupon == "":
        return 0
    elif coupon == "FLAT100":
        return 100
    elif coupon == "10%OFF":
        return subtotal * 0.1
    else:
        print("Invalid Coupon")
        return 0


while True:

    print("\n---Order---")
    print("1.Display Menu")
    print("2.Place Order")
    print("3.Order History")
    print("4.Exit")

    choice = input("Enter your choice: ")

    if choice == "1":
        menu()

    elif choice == "2":

        name = input("Enter Your Name: ")

        if name not in user:
            user[name] = {
                "orders": [],
                "spent": 0
            }

        menu()

        subtotal = 0
        order_items = []

        while True:

            item = input("Enter Item No (0 to finish): ")

            if item == "0":
                break

            if item not in Menu:
                print("Invalid Item No")
                continue

            quantity = int(input("Enter Quantity: "))

            if quantity > Menu[item]['count']:
                print("Out of Stock")
                continue

            Menu[item]['count'] = Menu[item]['count'] - quantity
            subtotal = subtotal + (Menu[item]['price'] * quantity)

            order_items.append(Menu[item]['Name'] + "(" + str(quantity) + ")")

        coupon = input("Enter Coupon Code: ")

        discount = Coupon(subtotal, coupon)
        delivery = delivery_charge(subtotal)
        total = subtotal + delivery - discount

        print("\n----Final Bill----")
        print("Items:")

        for i in order_items:
            print("-", i)

        print("Subtotal:", subtotal)
        print("Discount:", discount)
        print("Delivery Charge:", delivery)
        print("Total Bill:", total)
        print("Thank You For Shopping")

        user[name]["orders"].append({
            "items": order_items,
            "amount": total
        })

        user[name]["spent"] = user[name]["spent"] + total
        total_order = total_order + 1

        print("Order placed Successfully")

    elif choice == "3":

        name = input("Enter Your Name: ")

        if name not in user:
            print("User Not Found")

        else:
            print("\n----Order History----")

            if len(user[name]["orders"]) == 0:
                print("No Orders Found")

            else:
                for order in user[name]["orders"]:
                    print("Items:")

                    for i in order["items"]:
                        print("-", i)

                    print("Amount:", order["amount"])
                    print()

    elif choice == "4":
        print("Thank You For Shopping")
        break

    else:
        print("Invalid Choice")