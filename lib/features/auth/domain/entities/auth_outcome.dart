/// A successful result produced by an authentication action.
enum AuthOutcome {
  authenticated,
  emailVerificationRequired,
  passwordResetRequested,
  externalProviderStarted,
}
