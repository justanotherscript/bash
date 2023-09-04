#!/usr/bin/env bash

if [ ! -e "/etc/ssh/sshd_config.d" ]; then
  mkdir /etc/ssh/sshd_config.d
fi

tee "/etc/ssh/sshd_config.d/01_hardening.conf" > /dev/null << EOF
ChallengeResponseAuthentication no
KerberosAuthentication no
GSSAPIAuthentication no
PermitEmptyPasswords no
Protocol 2
ClientAliveInterval 300
ClientAliveCountMax 2
MaxAuthTries 3
LoginGraceTime 5m
EOF
