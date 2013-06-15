define append_if($file, $line, $test, $refreshonly = 'false') {
  exec { "/bin/echo '$line' >> '$file'":
    unless      => "/bin/grep -Fxqe '$test' '$file'",
    path        => "/bin",
    refreshonly => $refreshonly,
  }
}

class essentials {
  group { "puppet" :
    ensure => present,
    name => "puppet";
  }

  package {
    "curl":
      ensure => installed;
    "libssl-dev":
      ensure => installed;
    "git-core":
      ensure => installed;
    "python":
      ensure => installed;
    "build-essential":
      ensure => installed;
    "unzip":
      ensure => installed;
    "vim":
      ensure => installed;
  }

  file { "/usr/local":
    recurse => true,
    group => "vagrant",
    owner => "vagrant";
  }

  append_if { git-helpers:
    file => "/home/vagrant/.bashrc",
    line => "# git helpers
            alias gd=\"git diff\"
            alias ga=\"git add\"
            alias gr=\"git rm\"
            alias gbd=\"git branch -D\"
            alias gst=\"git status\"
            alias gca=\"git commit -a -m\"
            alias gm=\"git merge --no-ff\"
            alias gpt=\"git push --tags\"
            alias gp=\"git push\"
            alias grh=\"git reset --hard\"
            alias gb=\"git branch\"
            alias gcob=\"git checkout -b\"
            alias gco=\"git checkout\"
            alias gba=\"git branch -a\"
            alias gcp=\"git cherry-pick\"
            alias gl=\"git log --pretty='format:%Cgreen%h%Creset %an - %s' --graph\"
            alias gpom=\"git pull origin master\"
            alias gpos=\"git pull origin staging\"
            alias gpop=\"git pull origin production\"
            alias gcd='cd \"`git rev-parse --show-toplevel`\"'",
    test => "# git helpers",
  }
}
