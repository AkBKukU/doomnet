<?php

class SiteHeader
{

	private $navListLinks;
	$siteHeader = new DOMElement("header","");

	public function __construct() 
	{
		$navListLinks = array("404: Link's not here man" => "/404");
	}
	
	public function __construct($navLinks) 
	{
		$navListLinks = $navLinks;
	}

// - Header
$siteBase->appendChild($siteHeader);
$siteHeader->setAttribute("id","SiteHeader");

// -- Interactive Header
$interactiveHeader = new DOMElement("form","");
$siteHeader->appendChild($interactiveHeader);
$interactiveHeader->setAttribute("id","interactiveHeader");
$interactiveHeader->setAttribute("method","post");

// --- Page Title
$pageTitle = new DOMElement("h1","AkBKukU");
$interactiveHeader->appendChild($pageTitle);
$fakePath = "/";
$pageTitle->textContent = $pageTitle->textContent.":".$fakePath."$";
$pageTitle->setAttribute("id","pageTitle");

// ---- Title Cursor
$titleCursor= new DOMElement("span","_");
$pageTitle->appendChild($titleCursor);
$titleCursor->setAttribute("id","titleCursor");
$titleCursor->setAttribute("class","blink");


// --- Header CLI
$headerCLI = new DOMElement("input","");
$interactiveHeader->appendChild($headerCLI);
$headerCLI->setAttribute("id","headerCLI");
$headerCLI->setAttribute("type","text");
$headerCLI->setAttribute("name","headerCLI");
$headerCLI->setAttribute("onclick","return(updateCLI(this))");
$headerCLI->setAttribute("onkeyup","return(updateCLI(this))");
$headerCLI->setAttribute("onkeydown","return(updateCLI(this))");
$headerCLI->setAttribute("onkeypress","return(updateCLI(this))");
$headerCLI->setAttribute("onmouseup","return(updateCLI(this))");
$headerCLI->setAttribute("onmousedown","return(updateCLI(this))");


// -- Global Nav
$globalNav = new DOMElement("nav","");
$siteHeader->appendChild($globalNav);
$globalNav->setAttribute("id","globalNav");
$globalNav->setAttribute("class","sideNav");


// --- Nav List
$navListLinks = array(
	"Recent"=>"/",
	"Posts"=>"/ploa",
	"Gallery"=>"/picgur",
	"Pages"=>"/stuff",
	"Projects"=>"/thingsdoing",
	"About"=>"/whois"
);

$navList = new DOMElement("ul","");
$globalNav->appendChild($navList);

$counter = 0;
foreach($navListLinks as $name => $link)
{
	$navElements["a"][] = new DOMElement("a","");
	$navList->appendChild($navElements["a"][$counter]);
	$navElements["a"][$counter]->setAttribute("href",$link);	

	$navElements["li"][] = new DOMElement("li",$name);
	$navElements["a"][$counter]->appendChild($navElements["li"][$counter]);
	
	$counter++;
}


}
?>
