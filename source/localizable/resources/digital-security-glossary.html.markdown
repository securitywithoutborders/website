<h1><i class="fas fa-book"></i> Digital Security Glossary</h1>

This glossary is intended to help non-technical readers to understand digital security educational material, [technical reports](https://securitywithoutborders.org/resources/targeted-surveillance-reports.html), and news article. You can send additions and modifications through our [GitHub repository](https://github.com/securitywithoutborders/website/blob/master/source/localizable/resources/digital-security-glossary.html.markdown).

- [Command & Control (C&C, or C2)](#cnc)
- [Distributed Denial of Service (DDoS)](#ddos)
- [Domain Name](#domain)
- [Exploit](#exploit)
- [Malware](#malware)
- [Indicators of Compromise (or just Indicators)](#ioc)
- [IP Address](#ip)
- [OAuth](#oauth)
- [Phishing](#phishing)
- [Security Key](#security-key)
- [Spearphishing](#spearphishing)
- [Server](#server)
- [Spyware](#spyware)
- [Two-Factor Authentication](#2fa)
- [U2F](#u2f)
- [Zero Day (or 0day)](#0day)

### <a name="cnc"></a>Command & Control (C&C, or C2)
Command & Control is a term (of military origin) generally used in the information security industry to refer to network infrastructure (typically [Servers](#server)) used by attackers to send command and receive responses from [Malware](#malware) under their control.

### <a name="ddos"></a>Distributed Denial of Service (DDoS)
A Distributed Denial of Service (DDoS) is a particular form of network attack used to render its target service unreachable. DDoS attacks are typically conducted by using multiple computers (often compromised, and in large amounts) to overflow the target service with large quantity of data (or requests) the service is not capable to process, effectively making it unreachable or not operational. Typically DDoS attacks target websites the attackers want to knock offline. DDoS attacks are used for criminal purposes (such as extortion or economic damage), or even as an [act of protest](https://www.schneier.com/blog/archives/2013/05/ddos_as_civil_d.html).

### <a name="domain"></a>Domain Name
A Domain Name, or more simply a *domain*, is a typically a string used to identify a particular [Server](#server) or collection of servers. Because servers over a network are generally reachable through an [IP Address](#ip), domain names provide a more memorable and descriptive reference. A domain, for example, can be *www.google.com* or *www.securitywithoutborders.org*.

### <a name="exploit"></a>Exploit
An Exploit is a software, or a command, or otherwise some data, that leverage a specific software vulnerability in order to execute some unwanted code, and/or cause some unexpected behavior in the target application. For example, an attacker might use a particular exploit during an attack, in order to execute code on a victim's computer that would result in an infection with a [Malware](#malware). Sometimes an exploit could take advantage of a vulnerability that is not known to the target application's developer or to the larger public. Such unknown vulnerabilities are commonly known as [Zero Days](#0day).

### <a name="malware"></a>Malware
Malicious software designed to perform some unwanted activity on the victim's infected device. The type of activity performed by malware can be various: from intercepting communications, to collecting banking credentials, to absing the computing power of the device.

### <a name="ioc"></a>Indicators of Compromise (or just Indicators)
Indicators of Compromise (IOC or IoC), or more simply *Indicators*, are pieces of information that are indicative of a particular attack. For example, indicators can be email addresses, [Domain Names](#domain) or [IP Addresses](#ip). Security researchers investigating an attack commonly collect such indicators and share them with the wider community, for example in order to implement detections in security products.

### <a name="ip"></a>IP Address
An IP Address is a numerical addresses used to identify computers over a network, such as the open Internet. An IP Address, for example, can be *1.1.1.1* or *216.56.200.48*. Because IP Addresses are typically hard to memorize, [Domain Names](#domain) are often registered to resolve to a particular IP Address.

### <a name="oauth"></a>OAuth
OAuth is a standard protocol generally used by website developers to delegate the authentication of users through a third party, and without requiring sharing of passwords. For example, Google offers an OAuth-based authentication process to permit application developers to support authentication of Google Accounts. Some examples could be desktop and mobile email client applications or calendar applications requesting to connect to Gmail. Unfortunately, OAuth is also often abused by attackers in order to perform a particular form of *Phishing* attack, generally called *OAuth Phishing*. Check our [Guide to Phishing](https://guides.securitywithoutborders.org/guide-to-phishing/) for more information.

### <a name="phishing"></a>Phishing
Phishing is commonly used to refer to a variety of social engineering attacks. More commonly it is used to refer to "*Credentials Phishing*", which consists in the creation of malicious clones of legitimate websites (such as Google or Facebook) used by attackers to trick targets in revealing their credentials. These fake pages are normally delivered through emails or social media messages. Check our [Guide to Phishing](https://guides.securitywithoutborders.org/guide-to-phishing/) for more information.

### <a name="security-key"></a>Security Key
Security Keys are hardware tokens (normally in the form of a USB stick) that are used for secure authentication to online services. It can be considered a form of *Two-Factor Authentication* (2FA). Contrary to other forms of 2FA, Security Keys are broadly considered to be resistant to *Phishing* attacks because of its physical and cryptographic properties. Check our [Guide to Phishing](https://guides.securitywithoutborders.org/guide-to-phishing/) for more information.

### <a name="spearphishing"></a>Spearphishing
"Spearphishing" is a term generally used to refer to targeted phishing or targeted malware attacks.

### <a name="server"></a>Server
A server is a computer generally connected to a network (or more commonly, available over the Internet) that provides a particular functionality to its clients. For example, a *Web Server* would be a computer configured to serve web pages to its visitors. As another example, a *Command & Control Server* would be a network-enabled computer acting as a [Command & Control](#cnc).

### <a name="spyware"></a>Spyware
Malicious software designed for the specific purpose of silently collecting data from the infected device. *Spyware* it is generally used to more specifically indicate this category of [Malware](#malware).

### <a name="2fa"></a>Two-Factor Authentication (or *Two-Factor Verification*, or *Two-Step Verification* or *2FA*)
"Two-Factor Authentication" (2FA) is generally used to refer to a secondary verification procedure during the authentication to an online service, in addition to the traditional username and password. *(Note: There are different types of 2FA, and depending on the implementation some variation of the term could be more appropriate.)* Some forms of 2FA include, for example, requesting a numerical token delivered via SMS to a registered for number, or requesting a numerical token retrieved from an app installed on a registered device. Check our [Guide to Phishing](https://guides.securitywithoutborders.org/guide-to-phishing/) for more information.

### <a name="u2f"></a>U2F
U2F is a standard protocol used for secure authentication to online services, typically through hardware tokens such as [Security Keys](#security-key).

### <a name="0day"></a>Zero Day (or 0day)
"Zero Day" is used to refer to software vulnerabilities that are not known to the developers of the target application. An [Exploit](#exploit) taking advantage of a Zero Day vulnerability can be particularly powerful and effective, because of the fact that, by being unknown to the developers of the affected software (or hardware, even), a fix is not available to its users. Security researchers who discover a Zero Day vulnerability in a popular application (such as a browser or an office suite) often trade or sell their discovery through companies or brokers, who then provide them typically to government customers interested in conducting intrusion operations.
