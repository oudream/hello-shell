#!/usr/bin/env bash

### java
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export HADOOP_HOME=/usr/local/hadoop
export PATH=$PATH:$HADOOP_HOME/bin



### java hello world

echo >> hello1 <<EOF
import java.awt.Dialog;
import java.awt.Label;
import java.awt.Window;

public class Main {
 public static void main(String[] args) {
  Dialog d = new Dialog(((Window)null),"Hello world!");
  d.setBounds(0, 0, 180, 70);
  d.add(new Label("Hello world!"));
  d.setVisible(true);
 }
}
EOF