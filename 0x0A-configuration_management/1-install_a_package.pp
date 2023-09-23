# Install flash package using exec resources for now
package { 'flask':
  ensure   => '2.1.0',
  provider => pip3,
  name     => 'flask',
}
