<?php
require_once("site.header.php");

// Global
error_reporting(E_ALL);
ini_set('display_errors', '1');


class SiteMain
{

	private	$HTMLOut = new DOMDocument;
	private $head =   new DOMElement("head","");
	private $title =  new DOMElement("title","AkBkukU")
	private $body =   new DOMElement("body","");

	private $pageRendered = false;


	// --- Nav List
	private $navListLinks = array(
		"Recent"=>"/",
		"Posts"=>"/ploa",
		"Gallery"=>"/picgur",
		"Pages"=>"/stuff",
		"Projects"=>"/thingsdoing",
		"About"=>"/whois"
	);

	/*
	 * Setup Document
	 */
	public function __construct() 
	{
		$HTMLOut->preserveWhiteSpace = false;
		$HTMLOut->formatOutput = true;
	}

	function __destruct()
	{
		if(!$pageRendered)
		{
			$this.renderPage();
		}
	}

	private function buildHead()
	{
		// - Meta charset
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
		$head->appendChild($title);
		
		// Head
		$HTMLOut->appendChild($head);
	}


	private function buildBody()
	{
		$siteBase = new DOMElement("div","");
		$body->appendChild($siteBase);
		$siteBase->setAttribute("id","siteBase");
		
		// Body
		$HTMLOut->appendChild($body);
	}

	
	public function renderPage()
	{
		echo $HTMLOut->saveXML($head);
		echo $HTMLOut->saveXML($body);
		$pageRendered = true;
	}

}
?>

