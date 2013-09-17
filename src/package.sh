#!/bin/sh
mvn -Dmaven.test.skip=true -Dcheckstyle.skip=true -Dpmd.skip=true package
