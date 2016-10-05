import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
	func application(application: UIApplication,
	                 didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let string = "https://lumaa.co/api/feedingprogram/"
        let url = NSURL(string: string)
        let request = NSMutableURLRequest(URL: url!)
        request.setValue("Token <YOURTOKENHERE>", forHTTPHeaderField: "Authorization")
        request.HTTPMethod = "GET"
        let session = NSURLSession.sharedSession()
        
        let tache = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if let antwort = response as? NSHTTPURLResponse {
                let code = antwort.statusCode
                print(code)
            }
        }
        tache.resume()
        
        
		return true
	}
}