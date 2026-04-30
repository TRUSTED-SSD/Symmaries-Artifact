/**
   @author Benjamin Livshits <livshits@cs.stanford.edu>
   
   $Id: Basic38.java,v 1.2 2006/04/04 20:00:40 livshits Exp $
 */
package securibench.micro.basic;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.StringTokenizer;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import securibench.micro.BasicTestCase;
import securibench.micro.MicroTestCase;

/**
 * @servlet description="secure version of Basic38"
 * @servlet vuln_count="0"
 */
public class Basic38 extends BasicTestCase implements MicroTestCase {
    private static final String FIELD_NAME = "name";
      
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter(FIELD_NAME);
        StringTokenizer tok1 = new StringTokenizer(name, "\t");
        StringTokenizer tok2 = new StringTokenizer("abc\tdef", "\t");
        
        while(tok1.hasMoreTokens() && tok2.hasMoreElements()) {
            PrintWriter writer = resp.getWriter();        

            writer.println(tok2.nextToken());              /* OK */
        }
    }

    public String getDescription() {
        return "secure version of Basic38";
    }

    public int getVulnerabilityCount() {
        return 0;
    }
}