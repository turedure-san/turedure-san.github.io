---
layout: page
title: "Contact"
permalink: /Contact/
---
<style>
  .contact-form label {
    display: block;
    margin-bottom: 1em;
  }

  .contact-form input,
  .contact-form textarea {
    width: 100%;
    padding: 0.5em;
    margin-top: 0.2em;
    box-sizing: border-box;
  }

  .contact-form button {
    margin-top: 1em;
    padding: 0.6em 1.2em;
    font-size: 1em;
    cursor: pointer;
  }
</style>

<div class="contact-form">
  <form
    action="https://formspree.io/f/movegbgr"
    method="POST"
  >
    <label>
      Name:
      <input type="text" name="text">
    </label>
    <label>
      Email:
      <input type="email" name="email">
    </label>
    <label>
      Message:
      <textarea name="message"></textarea>
    </label>
    <button type="submit">Send</button>
  </form>
</div>
