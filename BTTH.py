while True:
    n = int(input("Nhập số lượng nhân viên: "))
    print()

    for i in range(1, n + 1):
        print(f"Nhân viên {i}")
        name = input("Tên nhân viên: ")
        days = int(input("Số ngày đi làm: "))
        
        print("Thông tin nhân viên:")
        print(f"Tên: {name}")
        print(f"Số ngày đi làm: {days}")
        
        if days < 20:
            print("Cần cải thiện chuyên cần")
        else:
            print("Nhân viên chuyên cần tốt")
        print()

    choice = input("Tiếp tục chương trình? (y/n): ").lower()
    print()
    
    if choice != 'y':
        print("Chương trình kết thúc")
        break