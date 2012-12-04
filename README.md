# Description

This is a program designed to automate the generation of 
[ledger](https://github.com/ledger/ledger) entries from the chase mobile 
website.

# Requires

If you do not have Mechanize installed, you must run

	gem install mechanize

# Configuration

This program requires you set the `$LEDGER_FILE` environment variable to
your ledger file, or it will not work.

You can also set an optional `$BANK_INFO` environment variable to the path of a
yaml file with your login credentials, or the program will prompt you for the 
credentials if this variable is not set to an actual file.

A sample `bank_info_sample.yaml` is included

# Usage

Executing the file autobank.rb will login to your chase account via Mechanize, 
and check for transactions that have a posted date. These will then be turned into ledger entries and added to `$LEDGER_FILE`.

(Note: The date and text of the transaction description on the chase website is
the key used by this program to identify transactions)
