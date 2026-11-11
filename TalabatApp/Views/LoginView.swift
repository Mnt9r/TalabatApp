import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var store: AppStore
    @State private var email = ""
    @State private var password = ""
    @State private var error: String?
    @FocusState private var focusedField: Field?
    private enum Field { case email, password }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                    Text("talabat").fontWeight(.black)
                    Spacer()
                    Text("STUDENT DEMO").font(.caption2.bold())
                        .padding(8).background(Theme.peach, in: Capsule())
                }.font(.title).foregroundStyle(Theme.orange)

                FoodArt(emoji: "🍔", large: true).clipShape(RoundedRectangle(cornerRadius: 30))

                VStack(alignment: .leading, spacing: 8) {
                    Text("Good food.\nOne tap away.")
                        .font(.system(.largeTitle, design: .rounded, weight: .bold))
                    Text("Discover a new favourite around the corner.")
                        .foregroundStyle(.secondary)
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Welcome back").font(.title3.bold())
                    TextField("Email address", text: $email)
                        .keyboardType(.emailAddress).textContentType(.emailAddress)
                        .textInputAutocapitalization(.never).autocorrectionDisabled()
                        .focused($focusedField, equals: .email).submitLabel(.next)
                        .onSubmit { focusedField = .password }
                        .padding(16).background(Theme.background, in: RoundedRectangle(cornerRadius: 14))
                    SecureField("Password (6+ characters)", text: $password)
                        .focused($focusedField, equals: .password).submitLabel(.go)
                        .onSubmit(signIn)
                        .padding(16).background(Theme.background, in: RoundedRectangle(cornerRadius: 14))
                    if let error {
                        Text(error).font(.caption).foregroundStyle(.red)
                            .accessibilityLabel("Sign-in error: \(error)")
                    }
                    Button("Sign in to demo", action: signIn).buttonStyle(PrimaryButtonStyle())
                    Button {
                        password = ""
                        store.continueAsGuest()
                    } label: {
                        Text("Explore as a guest").font(.subheadline.bold())
                            .frame(maxWidth: .infinity, minHeight: 44)
                    }
                    DemoNotice(text: "Demo sign-in only. Use a made-up email and password. No account is created and credentials are not saved.")
                }
            }.padding(24)
        }
        .scrollDismissesKeyboard(.interactively)
        .background(Color(uiColor: .systemBackground))
    }

    private func signIn() {
        if store.signIn(email: email, password: password) {
            password = ""
            error = nil
            focusedField = nil
        } else {
            error = "Enter a valid email and a password with at least 6 characters."
        }
    }
}
