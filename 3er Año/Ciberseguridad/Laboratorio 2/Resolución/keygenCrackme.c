#include <iostream>

class Keygen {
public:
    int userId;

    void generatePassword() {
        int num = userId * 786;
        std::cout << "Password: " << ((num * 17)/12)+1991 << std::endl;
    }
};
int main() {
    Keygen keygen;

    // Asignar valores a las variables miembro
    std::cout << "Ingrese el UserID: ";
    std::cin >> keygen.userId;

    // Generar la contraseña
    keygen.generatePassword();
    return 1;
}