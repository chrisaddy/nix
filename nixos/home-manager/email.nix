{
  config,
  pkgs,
  username,
  inputs,
  ...
}:
{
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.notmuch = {
    enable = true;
    hooks = {
      preNew = "mbsync --all";
    };
  };

  # Email account configuration
  accounts.email = {
    accounts.gmail = {
      address = "chris.william.addy@gmail.com";
      imap = {
        host = "imap.gmail.com";
        port = 993;
        tls = {
          enable = true;
          useStartTls = false;
        };
      };
      mbsync = {
        enable = true;
        create = "maildir";
        expunge = "both";
        patterns = ["*" "![Gmail]*" "[Gmail]/Sent Mail" "[Gmail]/Starred" "[Gmail]/All Mail"];
      };
      msmtp.enable = true;
      notmuch.enable = true;
      primary = true;
      realName = "Chris Addy";
      signature = {
        text = ''
          Best regards,
          Chris Addy
        '';
        showSignature = "append";
      };
      passwordCommand = "gpg -q --for-your-eyes-only -d ~/.mailpass.gpg";
      smtp = {
        host = "smtp.gmail.com";
        port = 587;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };
      userName = "chris.william.addy@gmail.com";
    };
  };

  # Ensure necessary packages are installed
  home.packages = with pkgs; [
    notmuch
    isync # for mbsync
    msmtp
    gnupg # for password decryption
  ];
}
