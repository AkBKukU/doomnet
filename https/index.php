<!DOCTYPE html>
<html>


<?php
// Global
error_reporting(E_ALL);
ini_set('display_errors', '1');

require_once('content/php/class.WadInterface.php');

$DBM = new DBManager('localhost','root','password');
$DBM->displayPublicAlert("Go to Manager","dbmsettingstest.php");

$WI = new WadInterface();

$newdoc = new DOMDocument;
$newdoc->preserveWhiteSpace = false;
$newdoc->formatOutput = true;

// Head
$head = $newdoc->createElement("head","");
$newdoc->appendChild($head);

// - Meta
$charset = new DOMElement("meta","");
$head->appendChild($charset);
$charset->setAttribute("charset","utf-8");

// - Link: Style
$linkStyle = new DOMElement("link","");
$head->appendChild($linkStyle);
$linkStyle->setAttribute("rel","stylesheet");
$linkStyle->setAttribute("href","content/css/style.css");

// - Script
$script = new DOMElement("script"," ");
$head->appendChild($script);
$script->setAttribute("type","text/javascript");
$script->setAttribute("src","content/js/script.js");

// - Title
$title = new DOMElement("title","Maximum Doom");
$head->appendChild($title);


// Body
$body = $newdoc->createElement("body","");
$newdoc->appendChild($body);

$siteBase = new DOMElement("div","");
$body->appendChild($siteBase);
$siteBase->setAttribute("id","siteBase");

// - Header
$siteHeader = new DOMElement("header","");
$siteBase->appendChild($siteHeader);
$siteHeader->setAttribute("id","SiteHeader");
// --- Page Title
$pageTitle = new DOMElement("h1","Maximum Doom");
$siteHeader->appendChild($pageTitle);

// Page

$div = new DOMElement("div", "");
$body->appendChild($div);

$h2 = new DOMElement("h2", "Here is another");
$div->appendChild($h2);


echo $newdoc->saveXML($head);
echo $newdoc->saveXML($body);


	var_dump($WI->checkWad("atrium.wad"));
// "Yep";
?>

</html>
