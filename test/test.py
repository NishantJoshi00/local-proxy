from time import sleep
import requests


def test(successes: int, failures: int, a: int, b: int):
    try:
        response = requests.get('http://localhost:8080/index.html')
        output = response.text.strip()
        if output == 'a':
            a += 1
        elif output == 'b':
            b += 1

        if response.status_code == 200:
            successes += 1
        else:
            failures += 1
    except Exception as _:
        failures += 1
    return successes, failures, a, b


if __name__ == '__main__':
    successes = 0
    failures = 0
    a = 0
    b = 0
    try:
        while True:
            if a > b + 5000:
                a -= 1
            if b > a + 5000:
                b -= 1

            successes, failures, a, b = test(successes, failures, a, b)
            print(f'Failure rate: {failures / (successes + failures) * 100:.2f}%; As: {a / (a + b) * 100:.2f}%; Bs: {b / (a + b) * 100:.2f}%', end='\r')
            sleep(0.05)
    except KeyboardInterrupt:
        print(f'Failure rate: {failures / (successes + failures) * 100:.2f}%', end='\n')
    # print failure rate on the same line replacing the previous value with 2 floating point precision
