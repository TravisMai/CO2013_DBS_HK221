<h1 class="">Welcome to
  <?php echo $_settings->info('name') ?> - Manager site
</h1>
<style>
  #cover-image {
    width: calc(100%);
    height: 50vh;
    object-fit: cover;
    object-position: center center;
  }
</style>
<hr>
<div class="row">
  <div class="col-12 col-sm-4 col-md-12">
    <div class="info-box">

      <form action="process.php" method="post">
        <div class="row">

          <div class="form-group col-md-6">
            <label for="ssn" class="control-label">Ssn</label>
            <input type="text" id="ssn" name="ssn" class="form-control form-control-sm form-control-border" required>
          </div>
        </div>
        <div class="row">
          <div class="form-group col-md-6">
            <label for="fname" class="control-label">First Name</label>
            <input type="text" id="fname" name="fname" class="form-control form-control-sm form-control-border"
              required>
          </div>
          <div class="form-group col-md-6">
            <label for="lname" class="control-label">Last Name</label>
            <input type="text" id="lname" name="lname" class="form-control form-control-sm form-control-border"
              required>
          </div>
        </div>
        <div class="row">
          <div class="form-group col-md-6">
            <label for="dob" class="control-label">Date of birth</label>
            <input type="text" id="sob" name="dob" class="form-control form-control-sm form-control-border" placeholder="YYYY-MM-DD"
              required>
          </div>
        </div>
        <div class="row">
          <div class="form-group col-md-6">
            <label for="phone" class="control-label">Contact #</label>
            <input type="text" id="phone" name="phone" class="form-control form-control-sm form-control-border"
              required>
          </div>
          <div class="form-group col-md-6">
            <label for="company" class="control-label">Company</label>
            <input type="text" id="company" name="company" class="form-control form-control-sm form-control-border"
              placeholder="Optional">
          </div>
          <div class="form-group col-md-6">
            <label for="season" class="control-label">Season</label>
            <input type="text" id="season" name="season" class="form-control form-control-sm form-control-border"
              required>
          </div>
        </div>
        <div class="row">
          <div class="form-group col-md-12">
            <label for="address" class="control-label">Address</label>
            <textarea rows="3" id="address" name="address" class="form-control form-control-sm rounded-0"
              required></textarea>
          </div>
        </div>
        <div class="row align-item-end">
          <!-- /.col -->
          <div class="col-4" type="hidden">
            <button type="submit" name="save" value="submit" class="btn btn-primary btn-block btn-flat">Add
              Trainee</button>
          </div>
          <!-- /.col -->
        </div>
      </form>
      <!-- /.info-box-content -->
    </div>
    <!-- /.info-box -->
  </div>
</div>