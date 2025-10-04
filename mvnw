#!/bin/sh
# ----------------------------------------------------------------------------
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements. See the NOTICE file for additional
# information regarding copyright ownership. The ASF licenses this file
# to you under the Apache License, Version 2.0.
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Maven Start Up Batch script
# Required ENV vars:
#   JAVA_HOME - location of a JDK home dir
# Optional ENV vars:
#   M2_HOME - location of Maven installation
#   MAVEN_OPTS - parameters for Java VM
#   MAVEN_SKIP_RC - skip loading mavenrc files
# ----------------------------------------------------------------------------

set -e  # exit on any error

# Load mavenrc if not skipped
if [ -z "$MAVEN_SKIP_RC" ]; then
  [ -f /usr/local/etc/mavenrc ] && . /usr/local/etc/mavenrc
  [ -f /etc/mavenrc ] && . /etc/mavenrc
  [ -f "$HOME/.mavenrc" ] && . "$HOME/.mavenrc"
fi

# OS detection
cygwin=false
darwin=false
mingw=false

case "$(uname)" in
  CYGWIN*) cygwin=true ;;
  MINGW*) mingw=true ;;
  Darwin*)
    darwin=true
    if [ -z "$JAVA_HOME" ]; then
      if [ -x "/usr/libexec/java_home" ]; then
        JAVA_HOME="$(/usr/libexec/java_home)"
      else
        JAVA_HOME="/Library/Java/Home"
      fi
    fi
    ;;
esac

# Gentoo JAVA_HOME fallback
if [ -z "$JAVA_HOME" ] && [ -r /etc/gentoo-release ]; then
  JAVA_HOME="$(java-config --jre-home)"
fi

# Resolve M2_HOME if not set
if [ -z "$M2_HOME" ]; then
  PRG="$0"
  while [ -h "$PRG" ]; do
    ls=$(ls -ld "$PRG")
    link=$(expr "$ls" : '.*-> \(.*\)$')
    if expr "$link" : '/.*' > /dev/null; then
      PRG="$link"
    else
      PRG="$(dirname "$PRG")/$link"
    fi
  done
  saveddir=$(pwd)
  M2_HOME="$(cd "$(dirname "$PRG")/.." && pwd)"
  cd "$saveddir"
fi

# Convert paths for Cygwin
if $cygwin; then
  [ -n "$M2_HOME" ] && M2_HOME=$(cygpath --unix "$M2_HOME")
  [ -n "$JAVA_HOME" ] && JAVA_HOME=$(cygpath --unix "$JAVA_HOME")
  [ -n "$CLASSPATH" ] && CLASSPATH=$(cygpath --path --unix "$CLASSPATH")
fi

# Detect Java executable
if [ -z "$JAVACMD" ]; then
  if [ -n "$JAVA_HOME" ]; then
    if [ -x "$JAVA_HOME/jre/sh/java" ]; then
      JAVACMD="$JAVA_HOME/jre/sh/java"
    else
      JAVACMD="$JAVA_HOME/bin/java"
    fi
  else
    JAVACMD="$(unset -f command; command -v java)"
  fi
fi

if [ ! -x "$JAVACMD" ]; then
  echo "Error: JAVA_HOME is not defined correctly." >&2
  exit 1
fi

[ -z "$JAVA_HOME" ] && echo "Warning: JAVA_HOME environment variable is not set."

# Maven wrapper launcher
CLASSWORLDS_LAUNCHER=org.codehaus.plexus.classworlds.launcher.Launcher

# Find Maven project base directory
find_maven_basedir() {
  [ -z "$1" ] && echo "Path not specified" && return 1
  basedir="$1"
  wdir="$1"
  while [ "$wdir" != "/" ]; do
    [ -d "$wdir/.mvn" ] && { basedir="$wdir"; break; }
    wdir=$(cd "$wdir/.." && pwd)
  done
  echo "$basedir"
}

concat_lines() {
  [ -f "$1" ] && tr -s '\n' ' ' < "$1"
}

BASE_DIR=$(find_maven_basedir "$(pwd)")
[ -z "$BASE_DIR" ] && exit 1

# Automatically download maven-wrapper.jar if missing
WRAPPER_JAR="$BASE_DIR/.mvn/wrapper/maven-wrapper.jar"
WRAPPER_PROPS="$BASE_DIR/.mvn/wrapper/maven-wrapper.properties"
MVNW_VERSION="3.1.0"

if [ ! -r "$WRAPPER_JAR" ]; then
  jarUrl="https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/$MVNW_VERSION/maven-wrapper-$MVNW_VERSION.jar"
  [ -r "$WRAPPER_PROPS" ] && jarUrl=$(grep '^wrapperUrl=' "$WRAPPER_PROPS" | cut -d'=' -f2)
  
  if command -v wget >/dev/null; then
    wget -O "$WRAPPER_JAR" "$jarUrl" || rm -f "$WRAPPER_JAR"
  elif command -v curl >/dev/null; then
    curl -o "$WRAPPER_JAR" "$jarUrl" -f
  else
    JAVA_CLASS="$BASE_DIR/.mvn/wrapper/MavenWrapperDownloader.java"
    [ -e "$JAVA_CLASS" ] && "$JAVA_HOME/bin/javac" "$JAVA_CLASS"
    [ -e "$BASE_DIR/.mvn/wrapper/MavenWrapperDownloader.class" ] && "$JAVA_HOME/bin/java" -cp .mvn/wrapper MavenWrapperDownloader "$BASE_DIR"
  fi
fi

export MAVEN_PROJECTBASEDIR=${MAVEN_BASEDIR:-"$BASE_DIR"}
MAVEN_OPTS="$(concat_lines "$MAVEN_PROJECTBASEDIR/.mvn/jvm.config") $MAVEN_OPTS"

# Final command execution
exec "$JAVACMD" \
  $MAVEN_OPTS \
  $MAVEN_DEBUG_OPTS \
  -classpath "$MAVEN_PROJECTBASEDIR/.mvn/wrapper/maven-wrapper.jar" \
  "-Dmaven.home=${M2_HOME}" \
  "-Dmaven.multiModuleProjectDirectory=${MAVEN_PROJECTBASEDIR}" \
  org.apache.maven.wrapper.MavenWrapperMain "$@"

