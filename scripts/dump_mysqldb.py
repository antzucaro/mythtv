#!/usr/bin/python

import os
import sys
from time import strftime
from glob import glob

if len(sys.argv) < 3:
   print "\nError: incorrect number of arguments."
   print "Usage: dump_mysqldb.py <database> <keep copies>\n"
   sys.exit(1)

if not (sys.argv[2].isdigit()):
   print "\nError: <keep_copies> must be all digits.\n\n"
   sys.exit(1)
else:
   keep_copies=int(sys.argv[2])

# args
database=sys.argv[1]
user="mythtv"
timestamp=strftime("%Y%m%d.%H:%M:%S")
dump_dir="/home/%s" % user

try:
   os.chdir(dump_dir)
   os.umask(077)
   print "\nChanged directory to %s.\n" % (dump_dir)
except:
   print "\nError: can't access output directory.\n\n"
   sys.exit(2)


# build command, then execute it
cmd = "/usr/bin/mysqldump --skip-lock-tables -u %s %s" % (user,database)
cmd += " | gzip > %s.%s.data.tgz" % (database,timestamp)
os.system(cmd)
print "Done\n"

# find the other backups of the same type
bk_files = glob("%s.*.data.*" % database)
bk_files.sort()

if len(bk_files) <= keep_copies:
   sys.exit(0)

while keep_copies > 0:
   print "Keeping %s..." % bk_files.pop()
   keep_copies = keep_copies - 1

for i in bk_files:
   print "Removing %s..." % i
   os.unlink(i)
