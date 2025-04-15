package com.example.kmmunityapp

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform