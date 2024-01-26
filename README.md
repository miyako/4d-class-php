![version](https://img.shields.io/badge/version-20%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/4d-class-php)](LICENSE)
![downloads](https://img.shields.io/github/downloads/miyako/4d-class-php/total)

# 4d-class-php
Class to use external PHP interpreter in execute, interactive or CGI mode

## Introduction

The internal PHP Interpreter has been removedin v20 R3[^removed]. Now it is "strongly advised" to use `4D.SystemWoker` to execute PHP code. But how? 

To effectively replace the CGI-based `PHP Execute` with `4D.SystemWoker` you need to

1. Launch `php` once and keep it running
2. Talk to the interpreter through `stdIn` and hear back from it through `stdOut` and `stdErr`
3. Terminate the running `php` when you no longer need it

For 1. and 3. you need to keep track of the single instance of `4D.SystemWoker` that is bound to the PHP interpreter.

For 2. you need to implement a controller object and run your code in an execution context of a dialog or a worker. Ideally the controller would be a generic class that can be extended according to specific needs.

This project shares a set of classes to execute PHP from 4D by using an external interpeter and CGI (the `PHP Execute` command), interactive mode, or one-shot execute mode. 

### Execute

```4d
$PHP:=cs.PHP.new(cs._PHP_Controller; $ini)
$PHP.run($input)
//the data is returned synchronously
$stdOut:=$PHP.data
```

### Interactive

```4d
$PHP:=cs.PHP.new(cs._PHP_Controller; $ini)
$PHP.interactive()
//you can now post messages and receive data asynchronously
$PHP.controller.worker.postMessage($input+"\r\n")
```

### CGI

```4d
$ini:=File("/RESOURCES/php/php.ini")
$CGI:=cs.PHP_CGI.new(cs._PHP_CGI_Controller; $ini).cgi()
//you can now use PHP Execute
```

[^removed]: [Deprecation of PHP Commands & Removal of 4D Built-in PHP Interpreter](https://blog.4d.com/deprecation-of-php-commands-removal-of-4d-built-in-php-interpreter/)
