def check_element_existence(element_to_check, my_list):
    if element_to_check in my_list:
        print(f'Yes, the element "{element_to_check}" exists.')
    else:
        print(f'No, the element "{element_to_check}" does not exist.')

# Example usage
my_list = ["orange", "banana", "grape", "apple", "kiwi"]
element_to_check = "apple"

check_element_existence(element_to_check, my_list)
