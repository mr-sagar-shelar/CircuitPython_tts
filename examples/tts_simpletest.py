# SPDX-FileCopyrightText: 2017 Scott Shawcroft, written for Adafruit Industries
# SPDX-FileCopyrightText: Copyright (c) 2024 Sagar Shelar
#
# SPDX-License-Identifier: Unlicense

from tts import greet

if greet() == '':
    print('Valid')
else:
    print('Invalid')
