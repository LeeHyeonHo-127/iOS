//
import UIKit
import MarkdownKit

class HowPredictDetailViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayMarkdownDocument(markdown: self.markdown, in: self.textView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "분석 방법"
    }
    
    func renderMarkdownDocument(markdown: String) -> NSAttributedString? {
        let markdownParser = MarkdownParser(font: UIFont.systemFont(ofSize: 17))
        return markdownParser.parse(markdown)
    }

    func displayMarkdownDocument(markdown: String, in textView: UITextView) {
        if let attributedString = renderMarkdownDocument(markdown: markdown) {
            textView.attributedText = attributedString
        } else {
            textView.text = "Failed to load markdown document."
        }
    }

    // Usage example
    var markdown = """
        

        
        """

    
    
   
    


}
