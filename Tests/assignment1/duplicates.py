"""
1) Check duplicate items from list A and list B and append to a new list. Using your
preferred programming language.
List A : [1,2,3,5,6,8,9]
List B : [3,2,1,5,6,0]
"""

def find_duplicates(list_a, list_b):
    """
    Find duplicate items that exist in both list_a and list_b.

    Args:
        list_a (list): First list of items.
        list_b (list): Second list of items.

    Returns:
        list: A list of duplicate items.
    """
    set_a = set(list_a)
    set_b = set(list_b)
    duplicates = list(set_a.intersection(set_b))
    return duplicates


if __name__ == "__main__":
    listA = [1,2,3,5,6,8,9]
    listB = [3,2,1,5,6,0]
    result = find_duplicates(listA, listB)
    print("Duplicates:", result)
