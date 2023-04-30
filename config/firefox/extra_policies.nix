{ pkgs, ... }:
{
  extraPolicies = {
    CaptivePortal = false;
    DisableFirefoxStudies = true;
    DisablePocket = true;
    DisableTelemetry = true;
    DisableFirefoxAccounts = true;
    NoDefaultBookmarks = true;
    OfferToSaveLogins = false;
    OfferToSaveLoginsDefault = false;
    PasswordManagerEnabled = false;

    FirefoxHome = {
      Search = true;
      Pocket = false;
      Snippets = false;
      TopSites = false;
      Highlights = false;
    };

    UserMessaging = {
      ExtensionRecommendations = false;
      SkipOnboarding = true;
    };
  };
}
