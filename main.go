package main

import (
    "github.com/gin-gonic/gin"
    "net/http"
)

func main() {
    r := gin.Default()

    // 根路由，返回简单的 Hello World 文本
    r.GET("/", func(c *gin.Context) {
        c.String(http.StatusOK, "Hello World v0.3!")
    })

    // /ping 路由，返回一个简单的 JSON 响应
    r.GET("/ping", func(c *gin.Context) {
        c.JSON(http.StatusOK, gin.H{
            "message": "pong",
        })
    })

    // 运行服务器，默认监听 8080 端口
    r.Run() // 监听并在 0.0.0.0:8080 上启动服务
}

