class windows_updates() {
  file { 'C:\\Program Files\\WindowsPowerShell\\Modules\\PSWindowsUpdate':
    ensure             => directory,
    recurse            => true,
    source_permissions => ignore,
    source             => 'puppet:///modules/windows_updates'
  }->
  file { 'C:\\ProgramData\\InstalledUpdates':
    ensure             => directory,
    recurse            => true,
    source_permissions => ignore
  }
}

=================================


=====================================


==================================

define windows_updates::kb (
  $ensure      = 'enabled',
  $kb          = $name,
  $maintwindow = undef
){
  require windows_updates

  case $ensure {
    'enabled', 'present': {
      case $kb {
        default: {
          #Run update if it hasn't successfully run before
          exec { "Install ${kb}":
            command   => template('windows_updates/install_kb.ps1.erb'),
            creates   => "C:\\ProgramData\\InstalledUpdates\\${kb}.flg",
            provider  => 'powershell',
            timeout   => 14400,
            logoutput => true,
            schedule  => $maintwindow
          }
        }
      }
    }
    default: {
      fail('Invalid ensure option!\n')
    }
  }
}



=========================================

