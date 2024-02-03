def find_largest_number(file_path):
    try:
        with open(file_path, 'r') as file:
            numbers = [float(line.strip()) for line in file]
            if not numbers:
                raise ValueError("The file is empty")
            
            largest_number = max(numbers)
            print(f"The largest number is: {largest_number}")

    except FileNotFoundError:
        print(f"Error: File '{file_path}' not found.")
    except ValueError as e:
        print(f"Error: {e}")

# Example usage
find_largest_number("count")
