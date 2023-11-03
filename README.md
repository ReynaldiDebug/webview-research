- Is the user session shared between Webview instances (instance 1, instance 2, headless Webview)?
  - We found that cookies and other web storage are shared among all instances created within the application. Both regular Webviews and headless mode Webviews share web storage. You can think of Webview instances (regular and headless) as browser tabs within a single browser instance. The plugin we are using (flutter_inappwebview) also provides a Singleton Object that we can use to access browser storage.
- Is the user session shared between the user's browser (the browser installed on the user's device) and the Webview browser?
  - After testing and simulating this process, we found that it is not possible.
- Are there any blockers for the next browser feature?
  - After checking Chrome Platform Status and WebKit documentation (Safari iOS), we didn't identify any new features from either platform that could impede the development or functionality of this feature.
- For both Android and iOS, they both have the same behavior.

```
From this research, what's essential for us is the user session shared between Webview instances (instance 1, instance 2, headless Webview). With the Webview's ability to share web storage among all instances, we can allocate Webview instances for specific processes. For example, We can use a headless Webview for user session validation and for scraping shopping cart data in the background and create a regular Webview instance specifically for the login process and etc. Additionally, the functions provided by the Webview plugin allow us to manage cookies and other storage directly from Flutter.
```