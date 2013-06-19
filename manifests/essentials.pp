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
    "bash-completion": 
      ensure => installed;
    "build-essential":
      ensure => installed;
    "curl":
      ensure => installed;
    "git-core":
      ensure => installed;
    "libssl-dev":
      ensure => installed;
    "python":
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
    line => "\n# git helpers\nalias gd=\"git diff\"\nalias ga=\"git add\"\nalias gr=\"git rm\"\nalias gbd=\"git branch -D\"\nalias gst=\"git status\"\nalias gca=\"git commit -a -m\"\nalias gm=\"git merge --no-ff\"\nalias gpt=\"git push --tags\"\nalias gp=\"git push\"\nalias grh=\"git reset --hard\"\nalias gb=\"git branch\"\nalias gcob=\"git checkout -b\"\nalias gco=\"git checkout\"\nalias gba=\"git branch -a\"\nalias gcp=\"git cherry-pick\"\nalias gl=\"git log --pretty='format:%Cgreen%h%Creset %an - %s' --graph\"\nalias gpom=\"git pull origin master\"\nalias gpos=\"git pull origin staging\"\nalias gpop=\"git pull origin production\"\nalias gcd='cd \"`git rev-parse --show-toplevel`\"'",
    test => "# git helpers",
  }
}
