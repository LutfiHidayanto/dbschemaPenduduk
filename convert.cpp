#include <bits/stdc++.h>

using namespace std;

signed main() {
    ios::sync_with_stdio(0);
    cin.tie(0);
    cout.tie(0);

    string s;
    vector<string> KK;
    while (s != "STOP") {
        cin >> s;
        KK.push_back(s);
    }
    vector<string> Kepala;
    s = "";
    while (s != "STOP") {
        cin >> s;
        Kepala.push_back(s);
    }
    int len = KK.size();
    for (int i = 0; i < len;++i) {
        cout << "UPDATE KELUARGA" << endl;
        cout << "SET Id_kepala_keluarga = \'" << Kepala[i] << "\'" << endl;
        cout << "WHERE Id_KK = \'" << KK[i] << "\'" << endl;
        cout << endl;
    }
}