package listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import javax.servlet.http.HttpSessionAttributeListener;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

@WebListener
public class MyListener implements ServletContextListener, HttpSessionListener, HttpSessionAttributeListener {

    private ServletContext servletContext = null;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        servletContext = sce.getServletContext();
        ConcurrentMap<String, String> onlineUsers = new ConcurrentHashMap<>();
        servletContext.setAttribute("onlineUsers", onlineUsers);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        servletContext = null;
    }

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        // New session created - set a creation time attribute
        se.getSession().setAttribute("_sessionCreatedTime", System.currentTimeMillis());
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        if (servletContext == null) return;
        HttpSession session = se.getSession();
        String username = (String) session.getAttribute("loginUser");

        if (username != null && servletContext != null) {
            ConcurrentMap<String, String> onlineUsers =
                (ConcurrentMap<String, String>) servletContext.getAttribute("onlineUsers");
            if (onlineUsers != null) {
                onlineUsers.remove(session.getId());
                servletContext.setAttribute("onlineUsers", onlineUsers);
            }
        }
    }

    @Override
    public void attributeAdded(javax.servlet.http.HttpSessionBindingEvent se) {
        if (!"loginUser".equals(se.getName())) return;
        if (servletContext == null) return;

        String username = (String) se.getValue();
        HttpSession session = se.getSession();

        ConcurrentMap<String, String> onlineUsers =
            (ConcurrentMap<String, String>) servletContext.getAttribute("onlineUsers");
        if (onlineUsers == null) {
            onlineUsers = new ConcurrentHashMap<>();
        }
        onlineUsers.put(session.getId(), username);
        servletContext.setAttribute("onlineUsers", onlineUsers);
    }

    @Override
    public void attributeRemoved(javax.servlet.http.HttpSessionBindingEvent se) {
        if (!"loginUser".equals(se.getName())) return;
        if (servletContext == null) return;

        ConcurrentMap<String, String> onlineUsers =
            (ConcurrentMap<String, String>) servletContext.getAttribute("onlineUsers");
        if (onlineUsers != null) {
            onlineUsers.remove(se.getSession().getId());
            servletContext.setAttribute("onlineUsers", onlineUsers);
        }
    }

    @Override
    public void attributeReplaced(javax.servlet.http.HttpSessionBindingEvent se) {
        if (!"loginUser".equals(se.getName())) return;
        if (servletContext == null) return;

        String newUsername = (String) se.getValue();
        String oldUsername = se.getValue() != null ? se.getValue().toString() : null;

        ConcurrentMap<String, String> onlineUsers =
            (ConcurrentMap<String, String>) servletContext.getAttribute("onlineUsers");
        if (onlineUsers != null) {
            if (newUsername != null) {
                onlineUsers.put(se.getSession().getId(), newUsername);
            } else {
                onlineUsers.remove(se.getSession().getId());
            }
            servletContext.setAttribute("onlineUsers", onlineUsers);
        }
    }
}
