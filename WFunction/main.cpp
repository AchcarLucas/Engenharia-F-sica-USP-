#include <iostream>
#include <math.h>

// Código desenvolvido por Lucas Campos Achcar
// y = W(x) com z = x*e^x
// Ref: https://en.wikipedia.org/wiki/Lambert_W_function (Numerical evaluation)

using namespace std;

double euler = 2.718281828459045235360287;

double ln(double x) {
    return log10(x) / log10(euler);
}

double log_base(double base, double x) {
    return log10(x) / log10(base);
}

double WFunction_NewtonApprox(double x, unsigned n) {
    double w = 0.0;
    for(unsigned i = 0; i < n; ++i)
        w = w - (((w*pow(euler, w)) - x) / (pow(euler, w) + w*pow(euler, w)));
    return w;
}

double WFunction_HalleyApprox(double x, unsigned n) {
    double w = 0.0;
    for(unsigned i = 0; i < n; ++i)
        w = w - ((w*pow(euler, w) - x) / (pow(euler, w)*(w + 1.0) - ((w + 2.0)*(w*pow(euler, w) - x) / (2.0*w + 2))));
    return w;
}

int main() {
    double value = 1.0;
    double w = WFunction_HalleyApprox(value, 100);

    cout << "W(1) " << w << endl;

    value = 2*ln(2);
    w = WFunction_HalleyApprox(value, 100);

    cout << "W(2*ln(2)) " << w << endl;

    // Solution x^x = 2

    value = ln(2);
    w = WFunction_HalleyApprox(value, 100);

    cout << "-------------------" << endl;
    cout << "x^x = 2" << endl;
    double result = ln(2) / w;
    cout << "x = (ln(2) / W[ln(2)]) -> x = " << result << endl;
    cout << result << "^" << result << " = " << pow(result, result) << endl;
    cout << "-------------------" << endl;

    /*
        2º Way
        x^x = 2
        ln(x^x) = ln(2)
        x*ln(x) = ln(2)

        x^ln(x) = x (I)

        (I) e^[ln(x)] * ln(x) = ln(2)

        W(x) = y -> y = x*e^x (II)

        (II) ln(x) = W(ln(2))
        x = e^[W(ln(x)]
    */

    result = pow(euler, WFunction_HalleyApprox(ln(2), 100));
    cout << "x = euler^[W(ln(2)] -> x = " << result << endl;
    cout << "-------------------" << endl;
    return 0;
}
